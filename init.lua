-- ====================================
-- = NILBOG's Neovim Config           =
-- ====================================

if vim.loader then
	vim.loader.enable()
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.autocmds")

require("plugins")
