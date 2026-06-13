# neobog.nvim

NILBOG's neovim config

## Install instructions

### 1. Install Neovim V0.11+

<details>
<summary><b>Linux Installation</b></summary>
Arch Linux

```
sudo pacman -S neovim
```

</details>

<details>
<summary><b>MacOS Installation</b></summary>
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

1. Create a new file for your LSP in `core/lsp/<lsp-name>.lua`
2. Find the definition spec in `:help lsp-handler`
3. Define the parameters based on the LSP JSON specification

## Adding Plugins

1. Add desired plugin's URL to `lua/plugins/init.lua`
2. Create setup file in `lua/plugins/<plugin>.lua`
3. Initialize plugin in `lua/plugins/init.lua`

## Plugins to add

- [ ] nvim-dap
- [ ] fidget.nvim
- [ ] nvim-colorizer
- [ ] pdf + latex plugins
- [ ] todo-comments

