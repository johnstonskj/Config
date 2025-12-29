# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

############################################################################
# Define path functions
############################################################################

function path_append {
    if [[ ":${PATH}:" != *":${1}:"* ]]; then
        export PATH=${PATH}:${1}
    fi
}

function path_append_if_exists {
    if [[ -d "${1}" ]]; then
        path_append "${1}"
    fi
}

function path_prepend {
    if [[ ":${PATH}:" != *":${1}:"* ]]; then
        export PATH="${1}:${PATH}"
    fi
}

function path_prepend_if_exists {
    if [[ -d "${1}" ]]; then
        path_prepend "${1}"
    fi
}

function man_path_append {
    if [[ ":$MANPATH:" != *":${1}:"* ]]; then
        export MANPATH="${MANPATH}:${1}"
    fi
}

function man_path_append_if_exists {
    if [[ -d "${1}" ]]; then
        man_path_append "${1}"
    fi
}

function function_path_append {
    if [[ ":${FPATH}:" != *":${1}:"* ]]; then
        export FPATH="${FPATH}:${1}"
    fi
}

function function_path_append_if_exists {
    if [[ -d "${1}" ]]; then
        function_path_append "${1}"
    fi
}

############################################################################
# Define script functions
############################################################################

function source_if_exists {
    # Don't bother to source zero-length files
    if [[ -s "${1}" ]]; then
        source "${1}"
    fi
}

############################################################################
# Define XDG functions
############################################################################

function shellmgr_xdg_init {
    function load_and_export {
        local file_name="${1}"
        while IFS= read -r line; do
            if [[ ${line} =~ ^XDG_[A-Z_]+= ]]; then
                eval "export ${line}"
            fi
        done < "${file_name}"
    }

    # This is for bootstrap purposes only
    export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}

    log_scope_enter "xdg-init"

    log_trace "XDG_CONFIG_HOME=${XDG_CONFIG_HOME}"

    if [[ -s ${XDG_CONFIG_HOME}/base-dirs.dirs ]]; then
        load_and_export ${XDG_CONFIG_HOME}/base-dirs.dirs
    else
        log_error "File ${XDG_CONFIG_HOME}/base-dirs.dirs not present"
    fi

    if [[ -s ${XDG_CONFIG_HOME}/user-dirs.dirs ]]; then
        load_and_export ${XDG_CONFIG_HOME}/user-dirs.dirs
    else
        log_error "File ${XDG_CONFIG_HOME}/user-dirs.dirs not present"
    fi

    if [[ ${SHLOG_LEVEL} -ge 5 ]]; then
        for line in $(env | grep -E "^XDG_"); do
            log_debug $line
        done
    fi

    log_scope_exit "xdg-init"
}

function xdg_cache_for {
    local package="${1}"
    echo "${XDG_CACHE_HOME}/${package}"
}

function xdg_cache_exists_for {
    [[ -d $(xdg_cache_for "${1}") ]]
}

function xdg_config_for {
    local package="${1}"
    echo "${XDG_CONFIG_HOME}/${package}"
}

function xdg_config_exists_for {
    [[ -d $(xdg_config_for "${1}") ]]
}

function xdg_data_for {
    local package="${1}"
    echo "${XDG_DATA_HOME}/${package}"
}

function xdg_data_exists_for {
    [[ -d $(xdg_data_for "${1}") ]]
}

function xdg_state_for {
    local package="${1}"
    echo "${XDG_STATE_HOME}/${package}"
}

function xdg_state_exists_for {
    [[ -d $(xdg_state_for "${1}") ]]
}

############################################################################
# Define phase functions
############################################################################

#
# Phases:
#
# ┌─────────┐
# │   env   │ ┄┄ Non-interactive environment
# └─────────┘
#     ⬇︎
# ┌─────────┐
# │ profile │ ┄┄ Sourced before `rc`
# └─────────┘
#     ⬇︎
# ┌─────────┐
# │   rc    │ ┄┄ Interactive environment
# └─────────┘
#     ⬇︎
# ┌─────────┐
# │  login  │ ┄┄ Login commands (not environment)
# └─────────┘
# 
# ┌─────────┐
# │ logout  │ ┄┄ Logout commands
# └─────────┘
#

__SHELLMGR_PREFIX=shellmgr
__SHELLMGR_SHELL=$(basename ${SHELL})

function shellmgr_add_completion_paths {
    log_scope_enter "shellmgr-completions"

    for dir in ${XDG_CONFIG_HOME}/*; do
        if [[ -f "${dir}/completions/$(basename ${dir}).__SHELLMGR_SHELL" ]] ; then
            function_path_append_if_exists "${dir}/completions"
        fi
    done

    log_scope_exit "shellmgr-completions"
}

function shellmgr_source_config {
    local phase=$1
    local shell_config="${__SHELLMGR_PREFIX}-${phase}"
    local shell_specific_config="${shell_config}.${__SHELLMGR_SHELL}"

    log_scope_enter ${shell_config}

    for dir in ${XDG_CONFIG_HOME}/*; do
        if [[ -f "${dir}/${shell_specific_config}" ]] ; then
            log_trace "sourcing ${dir}/${shell_specific_config}"
            source "${dir}/${shell_specific_config}"
        fi
        if [[ -f "${dir}/${shell_config}" ]] ; then
            log_trace "sourcing ${dir}/${shell_config}"
            source "${dir}/${shell_config}"
        fi
    done

    log_scope_exit ${shell_config}
}

function shellmgr_phase_env {
    shellmgr_source_config env
}

function shellmgr_phase_profile {
    shellmgr_source_config profile
}

function shellmgr_phase_rc {
    shellmgr_source_config rc
}

function shellmgr_phase_login {
    shellmgr_source_config login
}

function shellmgr_phase_logout {
    shellmgr_source_config logout
}

function __shellmgr_phase_path {
    local phase=$1

    case "${__SHELLMGR_SHELL}-${phase}" in
        zsh-env)
            echo ${ZDOTDIR}/.zshenv
            ;;
        zsh-profile)
            echo ${ZDOTDIR}/.zprofile
            ;;
        zsh-rc)
            echo ${ZDOTDIR}/.zshrc
            ;;
        zsh-login)
            echo ${ZDOTDIR}/.zlogin
            ;;
        zsh-logout)
            echo ${ZDOTDIR}/.zlogout
            ;;
        *)
        log_warning "Don't understand ${phase} for shell ${__SHELLMGR_SHELL}"
        ;;
    esac
}

function shellmgr_source_work {
    local phase=$1

    source_if_exists "$(__shellmgr_phase_path ${phase})-work"
}

function shellmgr_source_work_env {
    shellmgr_source_work env
}

function shellmgr_source_work_profile {
    shellmgr_source_work profile
}

function shellmgr_source_work_rc {
    shellmgr_source_work rc
}

function shellmgr_source_work_login {
    shellmgr_source_work login
}

function shellmgr_source_work_logout {
    shellmgr_source_work logout
}

############################################################################
# Define package-manager functions
############################################################################

function shellmgr_packagemgr_init {
    local package=$1
    local config_dir="${XDG_CONFIG_HOME}/${package}"
    local shell_config="${config_dir}/${__SHELLMGR_PREFIX}-packagemgr.zsh"
    local shell_specific_config="${shell_config}.${__SHELLMGR_SHELL}"

    log_scope_enter "${__SHELLMGR_PREFIX}-packagemgr ${package}"

    if [[ -s "${shell_specific_config}" ]]; then
        log_trace "sourcing ${shell_specific_config}"
        source "${shell_specific_config}"
    elif [[ -s "${shell_config}" ]]; then
        log_trace "sourcing ${shell_config}"
        source "${shell_config}"
    else
        log_warning "No package manager script '${__SHELLMGR_PREFIX}-packagemgr.zsh' found in ${config_dir}"
    fi

    log_scope_exit "${__SHELLMGR_PREFIX}-packagemgr ${package}"
}

function shellmgr_homebrew_init {
    shellmgr_packagemgr_init homebrew
}

function shellmgr_cargo_init {
    shellmgr_packagemgr_init cargo
}

############################################################################
# Define eval-init functions
############################################################################

function shellmgr_command_init {
    local command=$1; shift
    local arguments=($@)

    if command -v ${command} >/dev/null 2>&1; then
        log_trace "initializing ${command} with args: ${arguments[*]}"
        eval "$(${command} ${arguments})"
    else
        echo "echo \"Error: command ${command} not found, could not init\""
    fi
}