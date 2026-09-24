.PHONY: help build test install clean nuke e2e

# Default target
help:
	@echo "Marmot Dev Make Commands:"
	@echo "  make build    - Build the workspace (debug)"
	@echo "  make test     - Run all unit tests"
	@echo "  make e2e      - Run End-to-End tests using marmot-sim-llm (Mock Provider)"
	@echo "  make install  - Install marmot to ~/.cargo/bin"
	@echo "  make clean    - Standard cargo clean"
	@echo "  make nuke     - Deep clean (removes target/, cargo cache, and resets state)"

build:
	cargo build --workspace

test:
	cargo test --workspace

install:
	cargo install --path crates/marmot-cli --force

clean:
	cargo clean

nuke: clean
	@echo "Nuking all build caches and temporary states..."
	rm -rf target/
	rm -rf ~/.cargo/registry/cache/github.com-*
	rm -rf ~/.marmot/scratch/*
	@echo "Nuke complete. Next build will be completely fresh."

e2e:
	@echo "Starting E2E simulation with marmot-sim-llm..."
	# We pass MARMOT_SIM_MODE to force the engine to use the deterministic MockProvider
	# rather than reaching out to Anthropic/OpenAI, ensuring tests are free and fast.
	MARMOT_SIM_MODE=1 cargo test --workspace --test '*' --features "sim-llm" -- --nocapture
