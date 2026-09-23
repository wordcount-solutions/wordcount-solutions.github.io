.PHONY: build serve clean install check

ZOLA := $(shell if [ -f ./zola ]; then echo ./zola; elif command -v zola >/dev/null 2>&1; then echo zola; else echo ""; fi)
DOMAIN := stage.wordcount.solutions
DEST := simsong_static@simson.net:$(DOMAIN)

# Default target
all: build

# Build the site
build:
	@if [ -z "$(ZOLA)" ]; then \
		echo "Error: Zola not found. Please install Zola or place zola binary in current directory."; \
		echo "Visit https://www.getzola.org/documentation/getting-started/installation/"; \
		exit 1; \
	fi
	@echo "Building site with Zola..."
	$(ZOLA) build

# Serve the site locally (development mode)
serve:
	@if [ -z "$(ZOLA)" ]; then \
		echo "Error: Zola not found. Please install Zola or place zola binary in current directory."; \
		echo "Visit https://www.getzola.org/documentation/getting-started/installation/"; \
		exit 1; \
	fi
	@echo "Serving site locally at http://127.0.0.1:1111"
	$(ZOLA) serve

# Clean build artifacts
clean:
	@echo "Cleaning build directory..."
	/bin/rm -rf public

# Check if Zola is installed
check:
	@if [ -z "$(ZOLA)" ]; then \
		echo "Error: Zola not found. Please install Zola or place zola binary in current directory."; \
		echo "Visit https://www.getzola.org/documentation/getting-started/installation/"; \
		exit 1; \
	else \
		echo "Zola found: $(ZOLA)"; \
		$(ZOLA) --version; \
	fi

# Install dependencies (Zola check)
install: check

pub: build
	rsync --archive --delete --verbose public/. $(DEST)/.
