<h1 style="text-align: center;">RE:NeoVim</h1>
<hr>

## About

I would like to express my deep gratitude to the [NvChad](https://github.com/NvChad) team. Thanks to them, these repositories with configs exist, and it was on their basic config (still at 2.0) that I began to get acquainted with neovim.

## Screenshots

## Installation

### **Dependencies:**

- [neovim](https://neovim.io/)>=0.10
- [nodejs](https://nodejs.org/en/)
- `rust`
- `python3`
- `unzip`
- `gcc` or `clang`

**Optional:**

- `ripgrep`
- `fzf`

**ArchLinux:**

```sh
sudo pacman -S --needed neovim npm python python-pip rust unzip gcc ripgrep fzf
```

**Debian/Ubuntu/Termux:**

```sh
sudo apt install neovim npm unzip gcc
```

**Fedora:**

```sh
sudo dnf install neovim nodejs unzip gcc
```

**Gentoo:**

```sh
sudo emerge neovim nodejs python rust unzip ripgrep fzf
```

**Termux:**

```sh
pkg install neovim git clang unzip nodejs python python-pip rust ripgrep fzf
```

### **Installation config:**

```sh
git clone https://github.com/ReStranger/re-nvim.git ~/.config/nvim && nvim -c "MasonInstallAll"
```

## Update

**In folder `~/.config/nvim/` make `git pull` and in neovim make `:Lazy sync` and `:MasonInstallAll`**

## Uninstall

```sh
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```
