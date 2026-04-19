vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})

vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		vim.cmd.colorscheme(vim.g.colors_name)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "r" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
	end,
})
