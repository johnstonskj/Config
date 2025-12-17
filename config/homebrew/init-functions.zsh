# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

function homebrew_formula_prefix {
    local name="${1}"

    echo "${HOMEBREW_PREFIX}/opt/${name}"
}

function homebrew_formula_exists {
    local name="${1}"

    test -d $(homebrew_formula_prefix ${name})
}

function homebrew_set_formula_prefix {
    local name="${1}"
    local path=$(homebrew_formula_prefix ${name})

    typeset -x "${(U)name/-/_/}_PREFIX"="${path}"
}

function homebrew_set_formula_prefix_if_exists {
    local name="${1}"
    local path=$(homebrew_formula_prefix ${name})

    if [[ -d "${path}" ]]; then
        typeset -x "${(U)name/-/_/}_PREFIX"="${path}"
    fi
}

function homebrew_cask_prefix {
    local name="${1}"

    echo "${HOMEBREW_PREFIX}/Caskroom/$name"
}

function homebrew_cask_exists {
    local name="${1}"

    test -d $(homebrew_cask_prefix ${name})
}

function homebrew_set_cask_prefix {
    local name="${1}"
    local path=$(homebrew_cask_prefix ${name})

    typeset -x "${(U)name/-/_/}_PREFIX"="${path}"
}
function homebrew_set_cask_prefix_if_exists {
    local name="${1}"
    local path=$(homebrew_cask_prefix ${name})

    if [[ -d "${path}" ]]; then
        typeset -x "${(U)name/-/_/}_PREFIX"="${path}"
    fi
}

HOMEBREW_CMD="/opt/homebrew/bin/brew"
if command -v "${HOMEBREW_CMD}" >/dev/null 2>&1; then
    eval $(${HOMEBREW_CMD} shellenv)
else
    log_error "homebrew does not seem to be installed"
fi
