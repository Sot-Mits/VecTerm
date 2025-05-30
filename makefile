#Project Configuration
TARGET        = vecterm
CC            = clang
SRC_DIR       = ./src
INC_DIR       = ./inc
OBJ_DIR       = ./obj
BIN_DIR       = ./bin
BUILD         := $(if $(MAKECMDGOALS),$(firstword $(MAKECMDGOALS)),generic)

#File Discovery
SRCS          = $(wildcard $(SRC_DIR)/*.c)
OBJS          = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/$(BUILD)/%.o,$(SRCS))
DEPS          = $(wildcard $(INC_DIR)/*.h)

#Compiler Flags - Need changing if using a different compiler
COMMON_FLAGS  = -I$(INC_DIR) -Wall -Wextra -Wpedantic -fdiagnostics-color=always
GENERIC_FLAGS = -O3 -flto
NATIVE_FLAGS  = -O3 -flto -march=native
DEBUG_FLAGS   = -march=native -Og -ggdb3 -fsanitize=address,undefined

all: generic

#Generic build (optimized)
generic: CFLAGS = $(COMMON_FLAGS) $(GENERIC_FLAGS)
generic: BUILD = generic
generic: setup $(BIN_DIR)/$(TARGET)-$(BUILD)

#Native-tuned build
native: CFLAGS = $(COMMON_FLAGS) $(NATIVE_FLAGS)
native: BUILD = native
native: setup $(BIN_DIR)/$(TARGET)-$(BUILD)

#Debug build
debug: CFLAGS = $(COMMON_FLAGS) $(DEBUG_FLAGS)
debug: BUILD = debug
debug: setup $(BIN_DIR)/$(TARGET)-$(BUILD)

#Create directories
setup:
	@mkdir -p $(OBJ_DIR)/$(BUILD) $(BIN_DIR)

#Compile objects
$(OBJ_DIR)/$(BUILD)/%.o: $(SRC_DIR)/%.c $(DEPS)
	$(CC) $(CFLAGS) -c $< -o $@

#Main targets
$(BIN_DIR)/$(TARGET)-$(BUILD): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

#Clean build artifacts
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

#Help message
help:
	@echo "Available targets:"
	@echo "  generic  : Build generic version"
	@echo "  native   : Build with native CPU optimizations"
	@echo "  debug    : Build debug version with sanitizers"
	@echo "  clean    : Remove all build artifacts"
	@echo "  help     : Show this help message"
	@echo ""
	@echo "Binaries output to: $(BIN_DIR)"
	@echo "Objects output to: $(OBJ_DIR)"

.PHONY: generic native debug clean help setup
