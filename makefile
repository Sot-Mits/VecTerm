#Project Configuration
TARGET      = vecterm
CC          = clang
SRC_DIR     = ./src
INC_DIR     = ./inc
OBJ_DIR     = ./obj
BIN_DIR     = ./bin

#File Discovery
SRCS        = $(wildcard $(SRC_DIR)/*.c)
OBJS        = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))
DEPS        = $(wildcard $(INC_DIR)/*.h)

#Compiler Flags - Need changing if using a different compiler
COMMON_FLAGS = -I$(INC_DIR) -Wall -Wextra -Wpedantic -fdiagnostics-color=always
ALL_FLAGS    = -O3 -flto
OPT_FLAGS    = -O3 -flto -march=native
DEBUG_FLAGS  = -march=native -Og -ggdb3 -fsanitize=address,undefined

#Default build (optimized)
all: CFLAGS = $(COMMON_FLAGS) $(ALL_FLAGS)
all: setup $(BIN_DIR)/$(TARGET)

#Native-tuned build
native: CFLAGS = $(COMMON_FLAGS) $(OPT_FLAGS)
native: setup $(BIN_DIR)/$(TARGET)-native

#Debug build
debug: CFLAGS = $(COMMON_FLAGS) $(DEBUG_FLAGS)
debug: setup $(BIN_DIR)/$(TARGET)-debug

#Create directories
setup:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)

#Main targets
$(BIN_DIR)/$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

$(BIN_DIR)/$(TARGET)-native: $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

$(BIN_DIR)/$(TARGET)-debug: $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

#Compile objects
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(DEPS)
	$(CC) $(CFLAGS) -c $< -o $@

#Clean build artifacts
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

#Help message
help:
	@echo "Available targets:"
	@echo "  all      : Build optimized version (default)"
	@echo "  native   : Build with native CPU optimizations"
	@echo "  debug    : Build debug version with sanitizers"
	@echo "  clean    : Remove all build artifacts"
	@echo "  help     : Show this help message"
	@echo ""
	@echo "Binaries output to: $(BIN_DIR)"
	@echo "Objects output to: $(OBJ_DIR)"

.PHONY: all native debug clean help setup
