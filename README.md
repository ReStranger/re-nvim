<h1 style="text-align: center;">RE:NeoVim</h1>
<hr>

## About

## Screenshots

## Installation

### **Dependencies:**

- [neovim>=0.10](https://neovim.io/)
- [nodejs](https://nodejs.org/en/)
- `unzip`
- `gcc` or `clang`

**ArchLinux:**

```sh
sudo pacman -S --needed neovim npm unzip gcc
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
sudo emerge neovim nodejs unzip
```

### **Installation config:**

```sh
git clone https://github.com/ReStranger/re-nvim.git
cd re-nvim
mkdir -p ~/.config/nvim
cp -rf ./* ~/.config/nvim
nvim -c "MasonInstallAll"
```
