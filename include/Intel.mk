F90 ?=ifort

I=-I
M=-I
L=-L

ifneq ($(UNAME),Windows)
# Non-Windows (Linux) command line options for the intel compiler
version = $(shell $(F90) --version | grep -E '\(IFORT\) 13')

F90FLAGS += -assume realloc_lhs
F90FLAGS += -g -O0 -traceback -check uninit -check bounds -check stack -check uninit

else
# Windows command line options for the intel compiler
# Note hardwiring to 'Version 13'.  Trying a hack... MLR 2013-1031-1
# version = $(shell $(F90)  2>&1 | head -1 | grep 'Version 13')
version = $(shell $(F90)  2>&1 | head -1 | grep 'Version 1')

# Suppress version information with each compile.
F90FLAGS += /nologo
F90FLAGS += /assume:realloc_lhs
F90FLAGS += /Z7 /Od /traceback /check:uninit /check:bounds /check:stack /check:uninit
# Enable the Fortran preprocessor
F90FLAGS += /fpp

# Remove the DEBUG_FLAGS -g opsion.
DEBUG_FLAGS = /Z7
endif


# Common command line options.
F90FLAGS += -DSTRINGIFY_OPERATOR


CPPFLAGS +=-DSTRINGIFY_OPERATOR -DIntel
FPPFLAGS +=-DSTRINGIFY_OPERATOR -DIntel

# Check if the version of the compiler is 13
ifneq ($(version),)
  CPPFLAGS+=-DINTEL_13
  FPPFLAGS+=-DINTEL_13
endif


