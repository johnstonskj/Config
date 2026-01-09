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

### Sheldon

[sheldon](https://sheldon.cli.rs)

### Zsh-plugin Tool

To make it easy to develop new Zsh plugins I use [zsh-plugin](https://github.com/johnstonskj/rust-zsh-plugin-cli)