# -*- mode: sh; eval: (sh-set-shell "bash") -*-
#!/usr/bin/env bash

declare -a TOOLCHAINS=(
	stable
)

declare -a COMPONENTS=(
	rust-src
	clippy-preview
)

declare -a COMMANDS=(
	cargo-info
	cargo-tarpaulin
	cargo-update
	cargo-watch
	nu
	nu-lint
	release-plz
)

for toolchain in "${TOOLCHAINS[@]}"; do
	rustup toolchain add "${toolchain}"
done

for component in "${COMPONENTS[@]}"; do
	rustup component add "${component}"
done

for command in "${COMMANDS[@]}"; do
	cargo install --locked "${command}"
done
