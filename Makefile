# Makefile

SRC_DIR = slides
OUT_DIR = dist

# Find all markdown files in slides directory
MARKDOWN_FILES := $(wildcard $(SRC_DIR)/**/*.md)

# Extract directory name without extension
DIR_NAMES := $(patsubst $(SRC_DIR)/%.md,%,$(MARKDOWN_FILES))

# Build targets
all: $(DIR_NAMES)

# Build rule for each directory
$(DIR_NAMES):
	yarn slidev build "$(SRC_DIR)/$@.md" --out "$(OUT_DIR)/$@" --base "/$@"

# Phony target to clean generated files
# clean:
# 	rm -rf $(OUT_DIR)

.PHONY: all $(DIR_NAMES)
