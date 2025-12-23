# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

export CARGO_HOME="${CARGO_HOME:-${HOME}/.cargo}"

function cargo_all_installed {
    local list=$(cargo install --list |grep -E "^[^ ]" | cut -d ' ' -f 1 | tr '\n' ':')
    echo ":${list}:"
}

function cargo_crate_exists {
    [[ ":$(cargo_all_installed):" == *":${1}:"* ]]
}