#################################
# RISCV Toolchain
#################################
PREFIX = riscv64-unknown-elf-

GCC = $(PREFIX)gcc
CXX = $(PREFIX)g++
CP = $(PREFIX)objcopy
OBJDUMP = $(PREFIX)objdump
DG = $(PREFIX)gdb
SIZE = $(PREFIX)size

#################################
# Paths
#################################
BASE_DIR = $(abspath ../..)

GEMMINI_DIR = $(BASE_DIR)/generators/gemmini/software/gemmini-rocc-tests
GEMMINI_HEADERS = $(GEMMINI_DIR)/include/gemmini.h $(GEMMINI_DIR)/include/gemmini_params.h $(GEMMINI_DIR)/include/gemmini_nn.h $(GEMMINI_DIR)/include/gemmini_testutils.h

HPU_DIR = $(BASE_DIR)/generators/hpu/software
HPU_HEADERS = $(shell find $(HPU_DIR)/include -type d)
HPU_SRCS = $(shell find $(HPU_DIR)/common -name '*.c')

#################################
# Flags
#################################
# SoC Settings
ARCH = rv64imafdc
ABI = lp64d
ARCHFLAGS = -march=$(ARCH) -mabi=$(ABI)

CFLAGS  = -std=gnu99 -O2 -fno-common -fno-builtin-printf -Wall
CFLAGS += $(ARCHFLAGS)
LDFLAGS = -static

include ../libgloss.mk

.DEFAULT_GOAL := default


#################################
# Tests
#################################
TEST_SRCS := $(wildcard *.c)
TESTS := $(TEST_SRCS:.c=)

print:
	@echo $(TESTS)