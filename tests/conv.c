#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

typedef int8_t elem_t;
static const elem_t elem_t_max = 127;
static const elem_t elem_t_min = -128;
typedef int32_t acc_t;
typedef int64_t full_t;

#define HAS_MVIN_SCALE
typedef float scale_t;
typedef uint32_t scale_t_bits;

typedef int32_t scale_acc_t;
typedef uint32_t scale_acc_t_bits;

typedef float acc_scale_t;
typedef uint32_t acc_scale_t_bits;

#define MVIN_SCALE_IDENTITY 1.0

#define ACC_SCALE_IDENTITY 1.0

#ifdef HAS_MVIN_SCALE
#define GEMMINI_SCALE(x, scale) MVIN_SCALE((x), (scale))
#else
#define GEMMINI_SCALE(x, scale) (x)
#endif

#ifdef HAS_MVIN_ACC_SCALE
#define GEMMINI_ACC_SCALE(x, scale) MVIN_SCALE_ACC((x), (scale))
#else
#define GEMMINI_ACC_SCALE(x, scale) (x)
#endif


#ifdef __cplusplus
#define SAME_TYPE(x) decltype(x)
#else
#define SAME_TYPE(x) typeof(x)
#endif

#define ROUND_NEAR_EVEN(x) \
    ({ const SAME_TYPE(x) x_ = (x); \
         const long long i = x_; \
         const long long next = x_ < 0 ? x_ - 1 : x_ + 1; \
         SAME_TYPE(x) rem = x_ - i; \
         rem = rem < 0 ? -rem : rem; \
         SAME_TYPE(x) result = rem < 0.5 ? i : (rem > 0.5 ? next : ( \
                     i % 2 == 0 ? i : next)); \
         result; })

#define ACC_SCALE(x, scale) \
    ({float y = ROUND_NEAR_EVEN((x) * (scale)); y > INT8_MAX ? INT8_MAX : (y < INT8_MIN ? INT8_MIN : (acc_t)y);})

#define MVIN_SCALE(x, scale) \
    ({float y = ROUND_NEAR_EVEN((x) * (scale)); y > INT8_MAX ? INT8_MAX : (y < INT8_MIN ? INT8_MIN : (elem_t)y);})

#define MVIN_SCALE_ACC(x, scale) (x)

#define NO_ACTIVATION 0
#define RELU 1
#define LAYERNORM 2
#define IGELU 3
#define SOFTMAX 4

#define FAST

#define BATCH_SIZE   1
#define IN_ROW_DIM   21
#define IN_COL_DIM   21
#define IN_CHANNELS  3
#define OUT_CHANNELS 16
#define KERNEL_DIM   3
#define PADDING      1
#define STRIDE       2
#define NO_BIAS      false

#define POOL_SIZE    1   // 3
#define POOL_STRIDE  1   // 2
#define POOL_PADDING 0   // 1

#define NO_BIAS      false
#define NO_POOL      true

#define ACTIVATION   RELU

#define OUT_ROW_DIM  ((IN_ROW_DIM + 2 * PADDING - KERNEL_DIM) / STRIDE + 1)
#define OUT_COL_DIM  ((IN_COL_DIM + 2 * PADDING - KERNEL_DIM) / STRIDE + 1)
#define PATCH_SIZE   (KERNEL_DIM * KERNEL_DIM * IN_CHANNELS)
#define N_PATCHES    (BATCH_SIZE * OUT_ROW_DIM * OUT_COL_DIM)
#define POOL_OUT_ROW_DIM                                                       \
   ((OUT_ROW_DIM + 2 * POOL_PADDING - POOL_SIZE) / POOL_STRIDE + 1)
#define POOL_OUT_COL_DIM                                                       \
   ((OUT_COL_DIM + 2 * POOL_PADDING - POOL_SIZE) / POOL_STRIDE + 1)

#if NO_POOL == true &&                                                         \
    !(POOL_SIZE == 1 && POOL_STRIDE == 1 && POOL_PADDING == 0)
#error NO_POOL is not set correctly
#endif


static uint64_t read_cycles() {
    uint64_t cycles;
    asm volatile ("rdcycle %0" : "=r" (cycles));
    return cycles;

    // const uint32_t * mtime = (uint32_t *)(33554432 + 0xbff8);
    // const uint32_t * mtime = (uint32_t *)(33554432 + 0xbffc);
    // return *mtime;
}

static elem_t scale_and_sat(acc_t x, int act, acc_scale_t scale, acc_scale_t bert_scale) {
  // Apply I-GELU if needed
  if (act == IGELU) {
    const acc_scale_t sqrt_2 = 1.41421356237;

    const acc_scale_t S = bert_scale;

    const acc_scale_t S_erf = (-0.2888 * (S/sqrt_2)*(S/sqrt_2));
    const acc_t q1 = 1 / S_erf;
    const acc_t qb = -1.769 / (S / sqrt_2);
    const acc_t qc = 1.0 / (-0.2888 * (S / sqrt_2) * (S / sqrt_2));

    const acc_t q = x;

    const acc_t q_sign = q < 0 ? -1 : 1;
    const acc_t q_clipped = abs(q) > (-qb) ? (-qb) : abs(q);
    const acc_t q_poly = (q_clipped + qb)*(q_clipped + qb) + qc;
    const acc_t q_erf = q_sign * q_poly;

    x = q * (q_erf + q1);
  }

  // Scale value down and round it
  x = ACC_SCALE(x, scale);
  // Clip result
  x = x > elem_t_max ? elem_t_max : (x < elem_t_min ? elem_t_min : x);
  // Apply activation function
  if (act == RELU) {
    x = x < 0 ? 0 : x;
  }
  return x;
}

#ifdef HAS_MVIN_SCALE
#define GEMMINI_SCALE(x, scale) MVIN_SCALE((x), (scale))
#else
#define GEMMINI_SCALE(x, scale) (x)
#endif

#ifdef HAS_MVIN_ACC_SCALE
#define GEMMINI_ACC_SCALE(x, scale) MVIN_SCALE_ACC((x), (scale))
#else
#define GEMMINI_ACC_SCALE(x, scale) (x)
#endif


static void conv_cpu_without_pool(
        int batch_size, int in_row_dim, int in_col_dim, int in_channels,
        int out_channels, int out_row_dim, int out_col_dim,
        int stride, int input_dilation, int kernel_dilation, int padding, int kernel_dim,
        int in_stride, int weight_stride, int out_stride,
        bool wrot180, bool trans_output_1203, bool trans_input_3120,
        bool trans_weight_1203, bool trans_weight_0132,

        const elem_t * input,
        const elem_t * weights,
        const acc_t * bias,
        elem_t * output,

        int act, acc_scale_t scale) {

  bool no_bias = bias == NULL;

  for (int b = 0; b < batch_size; b++) {
    for (int orow = 0; orow < out_row_dim; orow++) {
      for (int ocol = 0; ocol < out_col_dim; ocol++) {
        for (int och = 0; och < out_channels; och++) {

          acc_t opixel = no_bias ? 0 : bias[och];

          for (int krow = 0; krow < kernel_dim; krow++) {
            if ((orow * stride + krow * kernel_dilation - padding) % input_dilation != 0)
              continue;

            const int irow = (orow * stride + krow * kernel_dilation - padding) / input_dilation;

            for (int kcol = 0; kcol < kernel_dim; kcol++) {
              if ((ocol * stride + kcol * kernel_dilation - padding) % input_dilation != 0)
                continue;

              const int icol = (ocol * stride + kcol * kernel_dilation - padding) / input_dilation;

              for (int kch = 0; kch < in_channels; kch++) {
                const elem_t *in = input + (b * in_row_dim * in_col_dim + irow * in_col_dim + icol) * in_stride + kch;
                if (trans_input_3120) {
                  // NHWC to CHWN
                  in = input + (kch * in_row_dim * in_col_dim + irow * in_col_dim + icol) * batch_size + b;
                }

                elem_t ipixel = irow < 0 || irow >= in_row_dim || icol < 0 || icol >= in_col_dim ?
                    0 : *in;

                const int krow_ = wrot180 ? kernel_dim - krow - 1 : krow;
                const int kcol_ = wrot180 ? kernel_dim - kcol - 1 : kcol;

                elem_t weight = *(weights + (krow_ * kernel_dim * in_channels + kcol_ * in_channels + kch) * weight_stride + och);
                if (trans_weight_1203) {
                  // HWIO to WIHO
                  weight = *(weights + (kch * kernel_dim * kernel_dim  + krow_ * kernel_dim + kcol_) * out_channels + och);
                } else if (trans_weight_0132) {
                  // HWIO to HWOI
                  weight = *(weights + (krow_ * kernel_dim * out_channels + kcol_ * out_channels + och) * in_channels + kch);
                }

                opixel += weight * ipixel;
              }
            }
          }

          elem_t *out = output + (b * out_row_dim * out_col_dim + orow * out_col_dim + ocol) * out_stride + och;
          if (trans_output_1203) {
            // NHWC to HWNC
            out = output + (orow * out_col_dim * batch_size + ocol * batch_size + b) * out_channels + och;
          }

          *out = scale_and_sat(opixel, act, scale, 0);
        }
      }
    }
  }
}

static void conv_cpu(
        int batch_size, int in_row_dim, int in_col_dim, int in_channels,
        int out_channels, int out_row_dim, int out_col_dim,
        int stride, int input_dilation, int kernel_dilation, int padding, int kernel_dim,
        int in_stride, int weight_stride, int out_stride,
        bool wrot180, bool trans_output_1203, bool trans_input_3120,
        bool trans_weight_1203, bool trans_weight_0132,

        const elem_t * input,
        const elem_t * weights,
        const acc_t * bias,
        elem_t * output,

        int act, acc_scale_t scale,
        int pool_size, int pool_stride, int pool_padding) {

  const bool no_pool = pool_stride == 0;
  if (no_pool) {
    conv_cpu_without_pool(
        batch_size, in_row_dim, in_col_dim, in_channels,
        out_channels, out_row_dim, out_col_dim,
        stride, input_dilation, kernel_dilation, padding, kernel_dim,
        in_stride, weight_stride, out_stride,
        wrot180, trans_output_1203, trans_input_3120,
        trans_weight_1203, trans_weight_0132,
        input, weights, bias, output,
        act, scale);
    return;
  }

  const bool no_bias = bias == NULL;
  const int pool_out_row_dim = (out_row_dim + 2 * pool_padding - pool_size) / pool_stride + 1;
  const int pool_out_col_dim = (out_col_dim + 2 * pool_padding - pool_size) / pool_stride + 1;

  for (int b = 0; b < batch_size; b++) {
    for (int porow = 0; porow < pool_out_row_dim; porow++) {
      for (int pocol = 0; pocol < pool_out_col_dim; pocol++) {
        for (int poch = 0; poch < out_channels; poch++) {

          elem_t running_max = 0;
          bool running_max_initialized = false;

          for (int pwrow = 0; pwrow < pool_size; pwrow++) {
            const int orow = porow * pool_stride + pwrow - pool_padding;

            for (int pwcol = 0; pwcol < pool_size; pwcol++) {
              const int ocol = pocol * pool_stride + pwcol - pool_padding;

              if (orow < 0 || orow >= out_row_dim || ocol < 0 || ocol >= out_col_dim) {
                if (!running_max_initialized || running_max < 0) {
                  running_max = 0;
                  running_max_initialized = true;
                }
              } else {

                acc_t opixel = no_bias ? 0 : bias[poch];

                for (int krow = 0; krow < kernel_dim; krow++) {
                  if ((orow * stride + krow * kernel_dilation - padding) % input_dilation != 0)
                    continue;

                  const int irow = (orow * stride + krow * kernel_dilation - padding) / input_dilation;

                  for (int kcol = 0; kcol < kernel_dim; kcol++) {
                    if ((ocol * stride + kcol * kernel_dilation - padding) % input_dilation != 0)
                      continue;

                    const int icol = (ocol * stride + kcol * kernel_dilation - padding) / input_dilation;

                    for (int kch = 0; kch < in_channels; kch++) {
                      const elem_t * in = input + (b * in_row_dim * in_col_dim + irow * in_col_dim + icol) * in_stride + kch;
                      if (trans_input_3120) {
                        // NHWC to CHWN
                        in = input + (kch * in_row_dim * in_col_dim + irow * in_col_dim + icol) * batch_size + b;
                      }

                      elem_t ipixel = irow < 0 || irow >= in_row_dim || icol < 0 || icol >= in_col_dim ?
                          0 : *in;

                      const int krow_ = wrot180 ? kernel_dim - krow - 1 : krow;
                      const int kcol_ = wrot180 ? kernel_dim - kcol - 1 : kcol;

                      elem_t weight = *(weights + (krow_ * kernel_dim * in_channels + kcol_ * in_channels + kch) * weight_stride + poch);
                      if (trans_weight_1203) {
                        // HWIO to WIHO
                        weight = *(weights + (kch * kernel_dim * kernel_dim  + krow_ * kernel_dim + kcol_) * out_channels + poch);
                      } else if (trans_weight_0132) {
                        // HWIO to HWOI
                        weight = *(weights + (krow_ * kernel_dim * out_channels + kcol_ * out_channels + poch) * in_channels + kch);
                      }

                      opixel += weight * ipixel;
                    }
                  }
                }

                opixel = scale_and_sat(opixel, act, scale, 0);
                if (!running_max_initialized || opixel > running_max) {
                  running_max = opixel;
                  running_max_initialized = true;
                }
              }

              if (pwrow == pool_size - 1 && pwcol == pool_size - 1) {
                elem_t * out = output + (b * pool_out_row_dim * pool_out_col_dim + porow * pool_out_col_dim + pocol) * out_stride + poch;
                if (trans_output_1203) {
                  // NHWC to HWNC
                  out = output + (porow * pool_out_col_dim * batch_size + pocol * batch_size + b) * out_channels + poch;
                }

                *out = running_max;
              }
            }
          }
        }
      }
    }
  }
}

void init_random(elem_t *buf, int len) {
   // elem_t i = 0;
   for (elem_t *ptr = buf; ptr < buf + len; ptr++) {
      // *ptr = (rand() % 32) - 16;
      *ptr = (rand() % 5) - 2;
   }
}

void init_random_acc(acc_t *buf, int len) {
   // elem_t i = 0;
   for (acc_t *ptr = buf; ptr < buf + len; ptr++) {
      // *ptr = (rand() % 32) - 16;
      *ptr = (rand() % 5) - 2;
   }
}

void init_zeros_acc(acc_t *buf, int len) {
   for (acc_t *ptr = buf; ptr < buf + len; ptr++) {
      *ptr = 0;
   }
}


int main(void) {

   printf("Input dimensions (rows by columns): %u by %u\n", IN_ROW_DIM,
          IN_COL_DIM);
#if NO_POOL == true
   printf("Output dimensions (rows by columns): %u by %u\n\n", OUT_ROW_DIM,
          OUT_COL_DIM);
#else
   printf("Pooled output dimensions (rows by columns): %u by %u\n\n", POOL_OUT_ROW_DIM,
          POOL_OUT_COL_DIM);
#endif

   static elem_t input[BATCH_SIZE][IN_ROW_DIM][IN_COL_DIM][IN_CHANNELS] = {[0 ... BATCH_SIZE - 1][0 ... IN_ROW_DIM - 1][0 ... IN_COL_DIM - 1][0 ... IN_CHANNELS - 1] = 1};
   static elem_t weights[KERNEL_DIM][KERNEL_DIM][IN_CHANNELS][OUT_CHANNELS] = {[0 ... KERNEL_DIM - 1][0 ... KERNEL_DIM - 1][0 ... IN_CHANNELS - 1][0 ... OUT_CHANNELS - 1] = 2};
   static acc_t  bias[OUT_CHANNELS] = {[0 ... OUT_CHANNELS - 1] = 3};
   static elem_t output[BATCH_SIZE][OUT_ROW_DIM][OUT_COL_DIM][OUT_CHANNELS];
   static elem_t pool_output[BATCH_SIZE][POOL_OUT_ROW_DIM][POOL_OUT_COL_DIM]
                            [OUT_CHANNELS];

#ifndef FAST
   printf("Randomize inputs...\n");
   init_random(&input[0][0][0][0], sizeof(input) / sizeof(elem_t));

   printf("Randomize weights...\n");
   init_random(&weights[0][0][0][0], sizeof(weights) / sizeof(elem_t));

   printf("Randomize bias...\n");
   if (NO_BIAS)
      init_zeros_acc(&bias[0], sizeof(bias) / sizeof(acc_t));
   else
      init_random_acc(&bias[0], sizeof(bias) / sizeof(acc_t));
#endif

   printf("CPU conv starts at cycle %lu\n", read_cycles());
   uint64_t start_cpu = read_cycles();

   conv_cpu(BATCH_SIZE, IN_ROW_DIM, IN_COL_DIM, IN_CHANNELS, OUT_CHANNELS,
            OUT_ROW_DIM, OUT_COL_DIM, STRIDE, 1, 1, PADDING, KERNEL_DIM,
            IN_CHANNELS, OUT_CHANNELS, OUT_CHANNELS, false, false, false, false,
            false, (elem_t *)input, (elem_t *)weights,
            NO_BIAS ? NULL : (acc_t *)bias,
#if NO_POOL == true
            (elem_t *)output,
#else
             (elem_t *)pool_output,
#endif
            ACTIVATION, ACC_SCALE_IDENTITY, POOL_SIZE,
            NO_POOL ? 0 : POOL_STRIDE, POOL_PADDING);

   uint64_t end_cpu = read_cycles();
   printf("CPU conv: %lu cycles\n", end_cpu - start_cpu);

  return 0;
}
