# neobog.nvim

NILBOG's neovim config

## Install instructions

### 1. Install Neovim V0.11+

<details>
<summary>Linux Installation</summary>
Arch Linux

```
sudo pacman -S neovim
```

</details>

<details>
<summary>MacOS Installation</summary>
Homebrew

```
brew install neovim
```

</details>

### 2. Clone this repository into your config directory

```
git clone https://github.com/NILBOGtheSavior/neobog.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

## Configuring LSP

### 1. Install the LSP on your system

### 2. Define the server config

1. Create a new file for your LSP in `lsp/<lsp-name>.lua`.
2. Find the definition spec in `:help lsp-handler`.
3. Define the parameters based on the LSP JSON specification.
4. Add the LSP to the list in `plugins/lsp.lua`.

## Plugins to add

- nvim-dap
- fidget.nvim
- lazydev.nvim
- nvim-colorizer
- pdf
- telescope
- todo-comments

