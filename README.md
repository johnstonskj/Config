# Dotfile Configuration

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

1. `.zshenv` is sourced on all invocations of the shell, unless the
   `-f` option is set. It should contain commands to set the command
   search path, plus other important environment variables. `.zshenv`
   should not contain commands that produce output or assume the shell is
   attached to a tty.
2. `.zprofile` is similar to `.zlogin`, except that it is sourced
   before `.zshrc`. `.zprofile` is meant as an alternative to `.zlogin`
   for ksh fans; the two are not intended to be used together, although
   this could certainly be done if desired.
3. `.zshrc` is sourced in **interactive** shells. It should contain
   commands to set up aliases, functions, options, key bindings, etc.
4. `.zlogin` is sourced in login shells. It should contain commands
   that should be executed only in login shells. `.zlogin` is not the
   place for alias definitions, options, environment variable settings,
   etc.; as a general rule, it should not change the shell environment at
   all. Rather, it should be used to set the terminal type and run a
   series of external commands (`fortune`, `msgs`, etc).
5. `.zlogout` is sourced when login shells exit.

### Sheldon

### Zsh-plugin Tool
