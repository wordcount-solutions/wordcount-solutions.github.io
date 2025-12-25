.PHONY: build serve clean install check

# Detect Zola binary - check for ./zola first, then zola in PATH
ZOLA = $(shell if [ -f ./zola ]; then echo ./zola; elif command -v zola >/dev/null 2>&1; then echo zola; else echo ""; fi)

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
	cd src && $(ZOLA) build
	@if [ -d src/public ] && [ ! -d public ]; then \
		mv src/public public && echo "Moved build output to public/"; \
	elif [ -d src/public ] && [ -d public ]; then \
		/bin/rm -rf public && mv src/public public && echo "Updated public/ directory"; \
	fi

# Serve the site locally (development mode)
serve:
	@if [ -z "$(ZOLA)" ]; then \
		echo "Error: Zola not found. Please install Zola or place zola binary in current directory."; \
		echo "Visit https://www.getzola.org/documentation/getting-started/installation/"; \
		exit 1; \
	fi
	@echo "Serving site locally at http://127.0.0.1:1111"
	cd src && $(ZOLA) serve

# Clean build artifacts
clean:
	@echo "Cleaning build directory..."
	/bin/rm -rf public src/public

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
	rsync --archive --delete --verbose public/. simson.net:wordcount.solutions/.
