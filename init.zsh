#!/usr/bin/env zsh

PROJECT_HOME=${PROJECT_HOME:-${HOME}/Projects}

ERR_MISSING_PREREQ=1
ERR_INSTALLER_FAIL=2
ERR_GIT_CLONE=3

function git_clone() {
    local repo=$1
    local parent_dir=${2:-${PROJECT_HOME}}
    local name=$3

    if [[ ! ${repo} =~ */* ]]; then
        repo="johnstonskj/${repo}"
    fi
    if [[ ! ${repo} == https:* ]]; then
        repo="https://github.com/${repo}"
    fi

    if [[ -z "${name}" ]]; then
        name=$(basename ${repo})
    fi

    if [[ ! -d ${parent_dir}/${name} ]]; then
        pushd ${parent_dir}
        if ! git clone ${repo} ${name}; then
            echo "Error: could not clone repository $repo into ${parent_dir}/${name}"
            exit ${ERR_GIT_CLONE}
        fi
        popd
    fi
}

function git_submod_init() {
    local dir=$1

    pushd ${dir}

    if ! git submodule init; then
        echo "Error: could not initialize git submodules in ${dir}"
        exit ${ERR_GIT_CLONE}
    fi
    if ! git submodule update; then
        echo "Error: could not update git submodule content in ${dir}"
        exit ${ERR_GIT_CLONE}
    fi

    popd
}

function brew_install_command() {
    local command=$1
    local package=${2:-${command}}

    if ! command -v ${command} > /dev/null 2>&1; then
        echo "Info: command ${command} not found, installing brew package ${package}."
        if ! brew install ${package}; then
            echo "Error: could not install package ${package}"
            exit ${ERR_INSTALLER_FAIL}
        fi
    fi
}

if ! command -v curl > /dev/null 2>&1; then
    echo "Error: not curl command found, that's pretty much a requirement."
    exit ${ERR_MISSING_PREREQ}
fi

if ! command -v brew > /dev/null 2>&1; then
    echo "Info: installing Homebrew package manager"
    if ! bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        echo "Error: could not install Homebrew"
        exit ${ERR_INSTALLER_FAIL}
    fi
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

if [[ ! -d ${PROJECT_HOME} ]]; then
    mkdir -p ${PROJECT_HOME}
fi

brew_install_command git

git_clone Config
git_submod_init Config

pushd "${PROJECT_HOME}/Config"
zsh init-links.zsh

pushd config/homebrew
brew bundle install --verbose --file ./Brewfile
popd

popd

if [[ "${USE_NIX}" =~ (#i)(true|yes|1) ]]; then
    if ! command - v nix; then
        echo "Info: installing nix command"
        if ! curl -L https://nixos.org/nix/install | sh; then
            echo "Error: could not install nix from nixos.org"
            exit ${ERR_INSTALLER_FAIL}
        fi
    fi
fi

if [[ -f ./init/init-links.zsh ]]; then
    echo "Info: initializing links"
fi

if [[ -f ./init/macos-defaults.zsh ]]; then
    echo "Info: initializing macos defaults"
fi

echo "Info: done."


