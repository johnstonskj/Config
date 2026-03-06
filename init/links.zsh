#!/usr/bin/env zsh

declare -A LINKMAP

THIS=$(dirname ${0:A})
ERRORS=0

function check_or_make_link() {
    linkname=$1
    target="${THIS}/$2"

    if [[ -L ${linkname} && "$(readlink ${linkname})" == "${target}" ]]; then
        echo "Info: link ${linkname} already setup correctly"
    elif [[ -L ${linkname} && "$(readlink ${linkname})" != "${target}" ]]; then
        echo "Error: link ${linkname} exists, but invalid"
    else
        if [[ -e ${linkname} ]]; then
            if [[ -e "${linkname}.pre-link" ]]; then
                echo rm "${linkname}.pre-link"
            fi
            mv "$linkname" "${linkname}.pre-link"
        fi
        if ln -s "${target:A}" "${linkname:A}"; then
            echo "Info: Created symlink from ${linkname} => ${target}"
        else
            echo "Error: could not create link ${linkname} => ${target}"
            ERRORS=$((ERRORS + 1))
        fi
    fi
}

function check_or_make_all() {
    local mapname=$1

    for linkname target in ${(Pkv)mapname}; do
        check_or_make_link "${linkname}" "${target}"
    done
}

LINKMAP=(
    "${HOME}/.bash_profile" "config/bash/dot-bash_profile"
    "${HOME}/.bashrc" "config/bash/dot-bashrc"
    "${HOME}/.cache" "cache"
    "${HOME}/.cargo" "local/state/cargo"
    "${HOME}/.claude" "local/state/claude"
    "${HOME}/.config" "config"
    "${HOME}/.cups" "local/state/cups"
    "${HOME}/.ipynb_checkpoints" "local/state/ipynb_checkpoints"
    "${HOME}/.ipython" "local/state/ipython"
    "${HOME}/.jupyter" "local/state/jupyter"
    "${HOME}/.kiro" "local/state/kiro"
    "${HOME}/.local" "local"
    "${HOME}/.npm" "local/state/npm"
    "${HOME}/.profile" "config/bash/dot-profile"
    "${HOME}/.redhat" "local/state/redhat"
    "${HOME}/.rustup" "local/state/rustup"
    "${HOME}/.rvm" "local/state/rvm"
    "${HOME}/.ssh" "local/state/ssh"
    "${HOME}/.tmux.conf" "config/tmux/dot-tmux.conf"
    "${HOME}/.vim" "config/vim"
    "${HOME}/.vimrc" "config/vim/dot-vimrc"
    "${HOME}/.vscode" "local/state/vscode"
    "${HOME}/.wakatime.cfg" "config/wakatime/wakatime.cfg"
    "${HOME}/.zlogin" "config/zsh/dot-zlogin"
    "${HOME}/.zshenv" "config/zsh/dot-zshenv"
    "${HOME}/.zshrc" "config/zsh/dot-zshrc"
)

check_or_make_all LINKMAP
