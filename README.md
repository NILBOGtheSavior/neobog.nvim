# neobog.nvim

## Installation

### Install Neovim

['stable'](https://github.com/neovim/neovim/releases/tag/stable)
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly)

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true

### Install Kickstart

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Clone kickstart.nvim

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/NILBOGtheSavior/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

