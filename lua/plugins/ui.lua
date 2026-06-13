local M = {}

local prose_filetypes = { "markdown", "text" }

function M.statusline()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "alpha" },
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
				refresh_time = 16,
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

function M.splash()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.val = {
		"                                                       ",
		" ███╗   ██╗███████╗ ██████╗ ██████╗  ██████╗  ██████╗  ",
		" ████╗  ██║██╔════╝██╔═══██╗██╔══██╗██╔═══██╗██╔════╝  ",
		" ██╔██╗ ██║█████╗  ██║   ██║██████╔╝██║   ██║██║  ███╗ ",
		" ██║╚██╗██║██╔══╝  ██║   ██║██╔══██╗██║   ██║██║   ██║ ",
		" ██║ ╚████║███████╗╚██████╔╝██████╔╝╚██████╔╝╚██████╔╝ ",
		" ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝  ",
		"                                                       ",
	}

	dashboard.section.buttons.val = {
		dashboard.button("n", "  ␣ New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("󱁐 f f", "  ␣ Find file", "<leader>ff"),
		dashboard.button("s", "  ␣ Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
		dashboard.button("q", "  ␣ Quit NVIM", ":qa<CR>"),
	}

	alpha.setup(dashboard.opts)
end

function M.gitsigns()
	require("gitsigns").setup({
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
	})
end

function M.clue()
	local wk = require("which-key")

	wk.setup({
		keys = {
			scroll_down = "<c-n>",
			scroll_up = "<c-b>",
		},
	})
	wk.add({
		{ "<leader>f", group = "Telescope" },
	})
	vim.keymap.set("n", "?", function()
		wk.show({ global = true })
	end, { desc = "All Keymaps" })

	vim.keymap.set("n", "<leader>?", function()
		wk.show({ global = false })
	end, { desc = "Local Keymaps" })
end

return M
