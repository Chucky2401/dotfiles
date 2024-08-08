# Dotfiles

Here all my dotfiles for a perfect configuration

## Requirements

The requirements depends of your distribution. Refer to your distribution, just below the common requirements, use your distribution package manager:

- git
- stow

<details>
<summary>Debian</summary>
### Debian

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
- sudo, must be in the group 'whell'
- eza

```shell
sudo bash -c 'pacman -S git stow zsh fd fzf bat eza neovim'
```
</details>

