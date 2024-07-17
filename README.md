<h1 style="text-align: center;">RE:NeoVim</h1>

## О конфиге

Хотелось бы выразить огромную благодарность команде [NvChad](https://github.com/NvChad). Благодаря им и существует данный репозиторий с конфигом и именно на их базовом конфиге (еще на 2.0) я начал знакомство с neovim.

## Скиншоты

## Установка

### **Зависимости:**

- [neovim](https://neovim.io/)>=0.10
- [nodejs](https://nodejs.org/en/)
- `rust`
- `python3`
- `unzip`
- `gcc` or `clang`

**Опционально:**

- `ripgrep`
- `fzf`

**ArchLinux:**

```sh
sudo pacman -S --needed neovim npm python python-pip rust unzip gcc ripgrep fzf
```

**Debian/Ubuntu:**

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

### **Установка конфига:**

```sh
git clone https://github.com/ReStranger/re-nvim.git ~/.config/nvim && nvim -c "MasonInstallAll"
```

## Обновление

**В папке `~/.config/nvim/` сделать `git pull` и в neovim сделать `:Lazy sync` и `:MasonInstallAll`**

## Удаление

```sh
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```
