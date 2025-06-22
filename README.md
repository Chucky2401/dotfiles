# Dotfiles

Here all my dotfiles for a perfect configuration

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
- eza<sup>\*</sup>
- tmux
- curl
- yarn
- npm
- zoxide<sup>\*\*</sup>

One-line install:

```bash
sudo apt install git gpg stow zsh fd-find bat ripgrep tmux curl yarn npm
```

<sup>\*</sup>To install eza on this distribution, you need to use these
commands:

```bash
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
```

<sup>\*\*</sup>Zoxide will be installed for all users when you source the file.
Otherwise you can run the command below:

```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

#### Neovim instruction

On Debian-based image, neovim is too old to work with NvChad. We will need to compile it yourself.
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

First, depends your distribution, you will need somes prerequisites.

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

Now you have all requirements, check out the dotfiles repo in your $HOME directory using git:

```bash
# Clone this repo
git clone --recurse-submodules -j8 https://github.com/Chucky2401/dotfiles.git ~/dotfiles

# Move to dotfiles directory
cd ~/dotfiles
```

Then use GNU stow to create symlinks:

```bash
stow -R .
```

## Post-Installation

I recommend you to start NeoVim a first time to initialize all LazyVim plugins
