local M = {}

local prose_filetypes = { "markdown", "text" }

function M.statusline()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			-- Use the dynamic global proxy if your custom theme defines it,
			-- otherwise let lualine extract color groups automatically.
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "alpha" }, -- Don't draw over your stream splash screen
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			globalstatus = false, -- Individual split bars look cleaner for stream setups
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
				refresh_time = 16, -- High performance ~60fps redraw loop
				events = {
					"WinEnter",
					"BufEnter",
					"BufWritePost",
					"SessionLoadPost",
					"FileChangedShellPost",
					"VimResized",
					"Filetype",
					"CursorMoved",
					"CursorMovedI",
					"ModeChanged",
				},
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = { "encoding", "filetype" },
			lualine_y = {
				{
					"prose_word_count",
					cond = function()
						return vim.tbl_contains(prose_filetypes, vim.bo.filetype)
					end,
				},
				{
					"progress",
					cond = function()
						return not vim.tbl_contains(prose_filetypes, vim.bo.filetype)
					end,
				},
			},
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
	})
end

return M
