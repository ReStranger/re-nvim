<h1 style="text-align: center;">RE:NeoVim</h1>
<hr>

## О конфиге

## Скиншоты

## Установка

### **Зависимости:**

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

### **Установка конфига:**

```sh
git clone https://github.com/ReStranger/re-nvim.git ~/.config/nvim && nvim -c "MasonInstallAll"
```
