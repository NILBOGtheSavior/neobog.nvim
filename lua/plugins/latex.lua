local M = {}

function M.setup()
	vim.g.vimtex_view_method = "zathura"
	vim.g.vimtex_compiler_method = "latexmk"

	vim.g.vimtex_compiler_latexmk = {
		aux_dir = "",
		out_dir = "",
		callback = 1,
		continuous = 1,
		executable = "latexmk",
		hooks = {},
		options = {
			"-verbose",
			"-file-line-error",
			"-synctex=1",
			"-interaction=nonstopmode",
		},
	}
end

return M
