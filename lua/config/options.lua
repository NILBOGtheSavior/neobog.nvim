-- appearance
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- behavior
vim.opt.mouse = "a"
vim.opt.confirm = true
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.scrolloff = 10
vim.opt.splitright = true
vim.opt.splitbelow = true

-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- clipboard
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
