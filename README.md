# Dotfile Configuration

This repository contains my machine configuration common across personal and work, macos and Linux.

Having looked at, and tried, some dotfile managers, including [GNU stow](https://www.gnu.org/software/stow/), I decided on a hybrid approach. I do have a lot of configuration files and folders that I would like to store in a single version controlled location but I also had a complex Zsh initialization which allowed new tools to contribute environment changes without having to edit the dot-zsh files themselves. I decided to go with a stow-like approach for managing configuration and data files and move all my environment settings into Zsh plugins.

## Repository Structure

The following shows the repository directory structure on the left. The middle
column shows any standard directory linked to the source, and the right column
is the name of a standard XDG environment variable that references this
location.

One odd-ball is the `opt` directory which is necessary on macos to support the
`xdg-user-dirs-update` command which uses the templates in `/opt/xdg` to
populate the `*.dirs` files.

```text
. ┬─ cache/             ⟶ ~/.cache      XDG_CACHE_HOME
  ├─ config/            ⟶ ~/.config     XDG_CONFIG_HOME
  │  ├─ homebrew/
  │  ├─ sheldon/
  │  ├─ zsh/
  │  ├─ base-dirs.dirs
  │  ├─ user-dirs.conf
  │  └─ user-dirs.dirs
  ├─ local/             ⟶ ~/.local
  │  ├─ bin/
  │  ├─ share/                          XDG_DATA_HOME
  │  └─ state/                          XDG_STATE_HOME
  └─ opt/
     └─ xdg/            ⟶ /opt/xdg
```

The following directories within `config` are important in getting a core system
working.

* **`homebrew`**; contains a set of homebrew `Brewfile`s used to bootstrap a
  new machine.
* **`sheldon`**; contains the list of Zsh plugins to be managed, and sourced,
  by the sheldon CLI.
* **`zsh`**; contains the files `.zshenv`, `.zshrc`, and `.zlogin`. The sheldon
  plug-in manager is called during `.zshrc`.

```bash
drwxr-xr-x@ .aws
lrwxr-xr-x@ .bash_profile -> ~/Config/config/bash/dot-bash_profile
lrwxr-xr-x@ .bashrc -> ~/Config/config/bash/dot-bashrc
lrwxr-xr-x@ .cache -> ~/Config/cache
lrwxr-xr-x@ .cargo -> ~/Config/local/state/cargo
lrwxr-xr-x@ .claude -> ~/Config/local/state/claude
lrwxr-xr-x@ .config -> ~/Config/config
lrwxr-xr-x@ .cups -> ~/Config/local/state/cups
lrwxr-xr-x@ .ipynb_checkpoints -> ~/Config/local/state/ipynb_checkpoints
lrwxr-xr-x@ .ipython -> ~/Config/local/state/ipython
lrwxr-xr-x@ .jupyter -> ~/Config/local/state/jupyter
lrwxr-xr-x@ .kiro -> ~/Config/local/state/kiro
lrwxr-xr-x@ .local -> ~/Config/local
lrwxr-xr-x@ .npm -> ~/Config/local/state/npm
lrwxr-xr-x@ .profile -> ~/Config/config/bash/dot-profile
lrwxr-xr-x@ .redhat -> ~/Config/local/state/redhat
lrwxr-xr-x@ .rustup -> ~/Config/local/state/rustup
lrwxr-xr-x@ .rvm -> ~/Config/local/state/rvm
lrwxr-xr-x@ .ssh -> ~/Config/local/state/ssh
lrwxr-xr-x@ .tmux.conf -> ~/Config/config/tmux/dot-tmux.conf
lrwxr-xr-x@ .vim -> ~/Config/config/vim
lrwxr-xr-x@ .vimrc -> ~/Config/config/vim/dot-vimrc
lrwxr-xr-x@ .vscode -> ~/Config/local/state/vscode
lrwxr-xr-x@ .wakatime.cfg -> ~/Config/config/wakatime/wakatime.cfg
lrwxr-xr-x@ .zlogin -> ~/Config/config/zsh/dot-zlogin
lrwxr-xr-x@ .zshenv -> ~/Config/config/zsh/dot-zshenv
lrwxr-xr-x@ .zshrc -> ~/Config/config/zsh/dot-zshrc
```

### Cache

```text
# Ignore everything in this directory, and sub-directories
**/*

# Except this file
!.gitignore
!**/.gitkeep
```

### Config

### Local Binaries

### Local Share

### Local State

## Configuration Plugins

TBD

Note, plugin names in bold are *bootstrap* plugins, these are actually sourced early in `.zshenv` as they provide functionality that may be used anywhere during initialization.

| Plugin Name                                                                | Description                                                                           |
| ---------------------------------------------------------------------------| ------------------------------------------------------------------------------------- |
| [`bat`](https://github.com/johnstonskj/zsh-bat-plugin)                     | Simple environment setup for using `bat` as a cat replacement.                        |
| [`brew`](https://github.com/johnstonskj/zsh-brew-plugin)                   | Simple environment setup for using `brew` as a package manager.                       |
| [`cargo`](https://github.com/johnstonskj/zsh-cargo-plugin)                 | Simple environment setup for using `cargo` as a package manager.                      |
| [`cargo`](https://github.com/johnstonskj/zsh-cargo-plugin)                 | Zsh plugin to setup core Zsh completion.                                              |
| [`emacs`](https://github.com/johnstonskj/zsh-emacs-plugin)                 | Simple environment setup for using `emacs` as primary editor.                         |
| [`eza`](https://github.com/johnstonskj/zsh-eza-plugin)                     | Simple plugin to set up aliases for the `eza` command, a modern replacement for `ls`. |
| [`fzf`](https://github.com/johnstonskj/zsh-fzf-plugin)                     | Zsh plugin to integrate the fzf tool into Zsh.                                        |
| [`getopt`](https://github.com/johnstonskj/zsh-getopt-plugin)               | Zsh plugin to set the correct path for get-opt installed via Homebrew.                |
| [`git`](https://github.com/johnstonskj/zsh-git-plugin)                     | Zsh plugin to set the correct path for Git installed via Homebrew.                    |
| [`gnupg`](https://github.com/johnstonskj/zsh-gnupg-plugin)                 | Zsh plugin to set up environment variables for GnuPG.                                 |
| [`gsed`](https://github.com/johnstonskj/zsh-gsed-plugin)                   | Zsh plugin to replace sed with GNU sed.                                               |
| [`guile`](https://github.com/johnstonskj/zsh-guile-plugin)                 | Configures environment variables for Guile Scheme programming language.               |
| [`hd`](https://github.com/johnstonskj/zsh-hd-plugin)                       | Zsh plugin to provide hd (hexdump) related alias(es).                                 |
| [`history`](https://github.com/johnstonskj/zsh-history-plugin)             | Zsh plugin to configure core history functionality.                                   |
| [`intelli_shell`](https://github.com/johnstonskj/zsh-intelli_shell-plugin) | Zsh plugin to set up IntelliShell environment.                                        |
| [`kiro`](https://github.com/johnstonskj/zsh-kiro-plugin)                   | Zsh plugin to set up environment when running in Kiro.                                |
| [`less`](https://github.com/johnstonskj/zsh-less-plugin)                   | Zsh plugin to set up environment for the command less.                                |
| [`llvm`](https://github.com/johnstonskj/zsh-llvm-plugin)                   | Zsh plugin to set up build flags for LLVM.                                            |
| [`mcfly`](https://github.com/johnstonskj/zsh-mcfly-plugin)                 | Plugin to integrate the `mcfly` command history tool.                                 |
| [`myip`](https://github.com/johnstonskj/zsh-myip-plugin)                   | Zsh plugin to provide myip command.                                                   |
| [`openssh`](https://github.com/johnstonskj/zsh-openssh-plugin)             | Zsh plugin to set up OpenSSH environment.                                             |
| [`orbstack`](https://github.com/johnstonskj/zsh-orbstack-plugin)           | Zsh plugin to set up environment for the OrbStack CLI.                                |
| [`**paths**`](https://github.com/johnstonskj/zsh-paths-plugin)             | Simple functions for managing PATH, MANPATH and FPATH.                                |
| [`racket`](https://github.com/johnstonskj/zsh-racket-plugin)               | Plugin to configure environment variables for Racket programming language.            |
| [`ruby`](https://github.com/johnstonskj/zsh-ruby-plugin)                   | Plugin to set up Ruby environment variables.                                          |
| [`rust`](https://github.com/johnstonskj/zsh-rust-plugin)                   | Zsh plugin to set additional Rust environment variables.                              |
| [`rvm`](https://github.com/johnstonskj/zsh-rvm-plugin)                     | Zsh plugin to set RVM environment variables.                                          |
| [`**shlog**`](https://github.com/johnstonskj/zsh-shlog-plugin)             | Logging utility functions for shell scripts.                                          |
| [`starship`](https://github.com/johnstonskj/zsh-starship-plugin)           | Setup starship prompt for Zsh shells.                                                 |
| [`todo`](https://github.com/johnstonskj/zsh-todo-plugin)                   | Zsh plugin to provide todo command to list TODO comments in files.                    |
| [`vim`](https://github.com/johnstonskj/zsh-vim-plugin)                     | Zsh plugin to redirect vi to Vim.                                                     |
| [`xcode`](https://github.com/johnstonskj/zsh-xcode-plugin)                 | Zsh plugin to add Xcode command line tools to path.                                   |
| [`**xdg**`](https://github.com/johnstonskj/zsh-xdg-plugin)                 | Zsh plugin to bootstrap/setup XDG Base Directory environment variables.               |
| [`zoxide`](https://github.com/johnstonskj/zsh-zoxide-plugin)               | Zsh plugin to initialize zoxide shell integration.                                    |
| [`**zplugins**`](https://github.com/johnstonskj/zsh-zplugins-plugin)       | Zsh plugin to provide standard plugin functionality for plugin development.           |

### Plugin zplugins

This implements *some* of the functionality of a plug-in manager, specifically looking for any `bin` or `functions` subdirectory and tracking aliases, functions, and
custom `path` and `fpath` entries. This greatly simplifies writing a plugin as can be shown in the following listing.

```bash
# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Name: example
# Description: Zsh plugin to show a zplugins plugin.
#

# Standard Setup Behavior

0="$(@zplugin_normalize_zero "${0}")"
@zplugin_declare_global example "${0}"

# Plugin Lifecycle

example_plugin_init() {
    builtin emulate -L zsh
    builtin setopt extended_glob warn_create_global typeset_silent no_short_loops rc_quotes no_auto_pushd

    @zplugin_register example
}
@zplugin_remember_fn completion_plugin_init

example_plugin_unload() {
    builtin emulate -L zsh

    @zplugin_unregister example
    unfunction example_plugin_unload
}

# Plugin Initialization

example_plugin_init

true
```

### Plugin xdg

### Plugin shlog

### Plugin paths

## Zsh Configuration

Zsh startup file sequence:

```text
                      ┌──────────────────┐               ┌────────────────┐
         ┌─────────┐  │   ┌───────────┐  │   ┌────────┐  │   ┌─────────┐  │
zsh ─┬─> │ .zshenv │ ─┼─> │ .zprofile │ ─┼─> │ .zshrc │ ─┼─> │ .zlogin │ ─┴···>
     │   └─────────┘  │   └───────────┘  │   └────────┘  │   └─────────┘
     └────── -f ──────┘                  └───────────────┘
                 ┌──────────┐
         ···─┬─> │ .zlogout │ ─┬─x
             │   └──────────┘  │
             └─────────────────┘
```

1. `.zshenv` is sourced on all invocations of the shell, unless the `-f` option is set. It should contain commands to set the command search path, plus other important environment variables. `.zshenv` should not contain commands that produce output or assume the shell is attached to a tty.
2. `.zprofile` is similar to `.zlogin`, except that it is sourced before `.zshrc`. `.zprofile` is meant as an alternative to `.zlogin` for ksh fans; the two are not intended to be used together, although this could certainly be done if desired.
3. `.zshrc` is sourced in **interactive** shells. It should contain commands to set up aliases, functions, options, key bindings, etc.
4. `.zlogin` is sourced in login shells. It should contain commands that should be executed only in login shells. `.zlogin` is not the place for alias definitions, options, environment variable settings, etc.; as a general rule, it should not change the shell environment at all. Rather, it should be used to set the terminal type and run a series of external commands (`fortune`, `msgs`, etc).
5. `.zlogout` is sourced when login shells exit.

Effective `.zshenv`

```bash
export ZDOTDIR=${ZDOTDIR:-${HOME}}

export XXDG_PROJECT_HOME=${XDG_PROJECT_HOME:-${HOME}/Projects}
export XXDG_LOCAL_ROOT=${HOME}/.local

bootstrap_plugin_load() {
    local plugin_name="${1}"
    local plugin_path="${XXDG_PROJECT_HOME}/zsh-${plugin_name}-plugin/${plugin_name}.plugin.zsh"

    if [[ -f ${plugin_path} ]]; then
        source ${plugin_path}
    else
        echo "Error: shell manager script ${plugin_path} not found."
    fi
}

bootstrap_plugin_load zplugins
bootstrap_plugin_load xdg
bootstrap_plugin_load shlog
bootstrap_plugin_load paths

unfunction bootstrap_plugin_load

export SHLOG_LEVEL=1 # Errors only

# Sessions

export SHELL_SESSIONS_DISABLE=1

# Top-level paths

path_append_if_exists /usr/local/bin
path_append_if_exists /usr/local/sbin
path_prepend_if_exists ${XXDG_LOCAL_ROOT}/bin

man_path_append_if_exists /usr/local/man

# Configure Zsh directories

export ZSH_CACHE_HOME=$(xdg_cache_for zsh)
if [[ ! -d ${ZSH_CACHE_HOME} ]]; then
    mkdir -p ${ZSH_CACHE_HOME}
fi

export ZSH_COMPDUMP="${ZSH_CACHE_HOME}/zcompdump"
if [[ ! -d ${ZSH_COMPDUMP} ]]; then
    mkdir -p ${ZSH_COMPDUMP}
fi

export ZSH_STATE_HOME=$(xdg_state_for zsh)
if [[ ! -d ${ZSH_STATE_HOME} ]]; then
    mkdir -p ${ZSH_STATE_HOME}
fi
```

Effective `.zlogin`

```bash
# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

export LC_ALL=en_US.UTF-8
export TERM="xterm-256color"
```

Effective `.zshrc`

```bash
# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

# Core/Standard Environment Variables

export ARCHFLAGS="-arch $(uname -m)"

# Plugin Manager (Sheldon)

eval "$(sheldon source)"
```

### Sheldon

[sheldon](https://sheldon.cli.rs)

### Zsh-plugin Tool

To make it easy to develop new Zsh plugins I use [zsh-plugin](https://github.com/johnstonskj/rust-zsh-plugin-cli)