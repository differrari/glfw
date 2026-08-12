# Sourced from https://gist.github.com/BlurrySquire/df3937ad9cac7d4d92dd6647a6be7c4c
# https://www.glfw.org/docs/latest/compile.html
# Read the bottom "Compiling GLFW manually" section

GCC := gcc
AR  := ar 

CFLAGS  := -std=gnu99 -O2
ARFLAGS := rcs

PLATFORM = linux
ifeq ($(PLATFORM),linux)
	CFLAGS += -D_GLFW_X11 -Ibuild
else ifeq ($(PLATFORM),windows)
	CFLAGS += -D_GLFW_WIN32 -D_CRT_NO_SECURE_WARNINGS
else ifeq ($(PLATFORM),macos)
	CFLAGS += -D_GLFW_COCOA
endif

SOURCES := $(shell find src -path "src/test" -prune -o -name "*.c")
OBJECTS := $(SOURCES:src/%.c=build/%.o)

TARGET := build/libglfw3.a

all: $(TARGET)

clean:
	rm -rf $(TARGET) build

$(TARGET): $(OBJECTS)
	$(AR) $(ARFLAGS) $@ $(OBJECTS)

build/%.o: src/%.c
	@mkdir -p $(dir $@)
	$(GCC) $(CFLAGS) -c $< -o $@