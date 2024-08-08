# Dotfiles

Here all my dotfiles for a perfect configuration

## Requirements

The requirements depends of your distribution. Refer to your distribution, just below the common requirements, use your distribution package manager:

- git
- stow

<details>
<summary>Debian/Ubuntu</summary>

### Debian/Ubuntu

- zsh
- fd-find
- bat
- neovim (see below for instruction)
- sudo, must be in the group
- eza

One-line install:
```shell
sudo bash -c 'apt install git stow zsh fd-find bat eza'

```

#### Neovim instruction

On Debian-based image, neovim is too old to work with NvChad. We will need to compile it yourself.
To that, report to the instruction below for arm-based device.
</details>

<details>
<summary>Alpine</summary>

### Alpine

- zsh
- fd
- bat
- neovim (see below if you are on an arm device)
- sudo, must be in the group 'wheel'
- eza

One-line install:
```shell
sudo sh -c 'apk add git stow zsh fd bat eza neovim'
```
</details>

<details>
<summary>Arch</summary>

### Arch

- zsh
- fd-find
- fzf
- bat
- neovim (see below if you are on an arm device)
- sudo, must be in the group 'wheel'
- eza

```shell
sudo bash -c 'pacman -S git stow zsh fd fzf bat eza neovim'
```
</details>

### Neovim Debian-based or arm device

For Debian-based distribution or arm device, you will need to build Neovim yourself.

First, depends your distribution, you will need somes prerequisites.

<details>
<summary>Debian/Ubuntu</summary>

#### Debian/Ubuntu


```shell
sudo apt install ninja-build gettext cmake unzip curl build-essential gcc libc6
```
</details>

<details>
<summary>Alpine</summary>

#### Alpine


```shell
apk add build-base cmake coreutils curl unzip gettext-tiny-dev musl-dev
```
</details>

<details>
<summary>Arch</summary>

#### Arch


```shell
pacman -S base-devel cmake unzip ninja curl
```
</details>

Now we will clone the repository and choose the stable version (all commands below must be run as root):

```shell
git clone https://github.com/neovim/neovim /opt/neovim

cd /opt/neovim
git checkout stable
```

Finally, follow instruction below according to your distribution:

<details>
<summary>Debian/Ubuntu</summary>

#### Debian/Ubuntu


```shell
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


```shell
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/usr/local install
```

`nvim` will be available in `/usr/local`
</details>

