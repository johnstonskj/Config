#!/usr/bin/env bash
# -*- mode: sh; eval: (sh-set-shell "bash") -*-

rustup  toolchain \
		install stable \
		--component rust-src \
		--component clippy-preview

rustup  toolchain \
		install nightly \
		--component rustc-dev \
		--component rust-src \
		--component llvm-tools

cargo default stable

declare -a COMMANDS=(
	cargo-info
	cargo-tarpaulin
	cargo-update
	cargo-watch
	nu
	nu-lint
	release-plz
)

for command in "${COMMANDS[@]}"; do
	cargo install --locked "${command}"
done
