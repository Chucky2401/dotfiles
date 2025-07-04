# Dotfiles

Here all my dotfiles for a perfect configuration (in my point of view)

## Requirements

The requirements depends of your distribution. Refer to your distribution below:

<details>
<summary>Debian/Ubuntu</summary>

### Debian/Ubuntu

- git
- gpg
- zsh
- fd-find
- ripgrep
- bat
- neovim (see below for instruction)
- sudo, must be in the group
- eza[^1]
- tmux
- curl
- yarn
- npm
- zoxide[^2]

One-line install:

```bash
sudo apt install git gpg stow zsh fd-find bat ripgrep tmux curl yarn npm
```

<sup>\*\*</sup>Zoxide will be installed for all users when you source the .zshrc
file, it will ask you password to run as root. Otherwise you can run the command
below:

```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

#### Neovim instruction

On Debian-based image, neovim is too old to work with LazyVim. We will need to
compile it yourself.

For that, report to the instruction below for arm-based device.
</details>

<details>
<summary>Alpine</summary>

### Alpine

- git
- gpg
- zsh
- fd
- grep
- ripgrep
- bat
- neovim (see below if you are on an arm device)
- sudo, must be in the group 'wheel'
- eza
- coreutils
- build-base
- npm
- bash
- tmux
- curl
- yarn
- npm
- zoxide

If you plan to use *lazygit* you have to install *ncurses* package too.

One-line install:

```bash
sudo apk add git gpg stow zsh fd bat eza grep ripgrep neovim coreutils build-base npm bash tmux curl yarn npm zoxide

# With lazygit support
sudo apk add git gpg stow zsh fd bat eza grep ripgrep neovim coreutils build-base npm bash tmux curl yarn npm zoxide ncurses
```

</details>

<details>
<summary>Arch</summary>

### Arch

- git
- gpg
- zsh
- fd
- ripgrep
- fzf
- bat
- neovim (see below if you are on an arm device)
- sudo, must be in the group 'wheel'
- eza
- tmux
- curl
- yarn
- npm
- zoxide

```bash
sudo pacman -S git gpg stow zsh fd fzf bat eza ripgrep neovim tmux curl yarn npm zoxide
```

</details>

### Neovim Debian-based or arm device

For Debian-based distribution or arm device, you will need to build Neovim yourself.

First, depends your distribution, you will need some prerequisites.

<details>
<summary>Debian/Ubuntu</summary>

#### Debian/Ubuntu

```bash
sudo apt install ninja-build gettext cmake unzip curl build-essential gcc libc6
```

</details>

<details>
<summary>Alpine</summary>

#### Alpine

```bash
apk add build-base cmake coreutils curl unzip gettext-tiny-dev musl-dev
```

</details>

<details>
<summary>Arch</summary>

#### Arch

```bash
pacman -S base-devel cmake unzip ninja curl
```

</details>

Now we will clone the repository and choose the stable version (all commands below must be run as root):

```bash
git clone https://github.com/neovim/neovim /opt/neovim

cd /opt/neovim
git checkout stable
```

Finally, follow instruction below according to your distribution:

<details>
<summary>Debian/Ubuntu</summary>

#### Debian/Ubuntu

```bash
make CMAKE_BUILD_TYPE=Release
cd build
cpack -G DEB
dpkg -i nvim-linux64.deb
```

`nvim` will be available in `/usr/bin`
</details>

<details>
<summary>Other distributions</summary>

#### Other distributions

```bash
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/usr/local install
```

`nvim` will be available in `/usr/local`
</details>

## Installation

Now you have all requirements, check out the dotfiles repo in your home directory using git:

```bash
# Clone this repo
git clone --recurse-submodules -j8 https://github.com/Chucky2401/dotfiles.git ~/dotfiles

# Move to dotfiles directory
cd ~/dotfiles
```

Then use GNU Stow to create symlinks:

```bash
stow -R .
```

## Post-Installation

I recommend you to start NeoVim a first time to initialize all LazyVim plugins.

For tmux, you will have to start a new session and install plugins.
After running the session, just hit `prefix, I` (`prefix, Shift + i`). In the config
files, the prefix is set to `Ctrl + Space` and `Ctrl + b`.

## Roadmap

- [ ] Adding atuin install script and information

[^1]: For Debian-based distribution, please report to [repo instruction](https://github.com/eza-community/eza/blob/main/INSTALL.md#debian-and-ubuntu)
[^2]: Zoxide will be installed for all users when you source the .zshrc
file, it will ask you password to run as root. Otherwise you can run this
command: `curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh`
