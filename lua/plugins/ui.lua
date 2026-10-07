local M = {}

local prose_filetypes = { "markdown", "text" }
local p = _G.theme_colors.get_palette()

function M.statusline()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = {
				normal = {
					a = { fg = p.bg, bg = p.green, bold = true },
					b = { fg = p.fg, bg = p.alt_bg },
					c = { fg = p.fg, bg = p.bg },
					z = { fg = p.bg, bg = p.green, bold = true },
				},
				insert = { a = { fg = p.bg, bg = p.blue, bold = true }, z = { fg = p.bg, bg = p.green, bold = true } },
				visual = {
					a = { fg = p.bg, bg = p.magenta, bold = true },
					z = { fg = p.bg, bg = p.green, bold = true },
				},
				replace = { a = { fg = p.bg, bg = p.red, bold = true }, z = { fg = p.bg, bg = p.green, bold = true } },
				command = {
					a = { fg = p.bg, bg = p.yellow, bold = true },
					z = { fg = p.bg, bg = p.green, bold = true },
				},
				inactive = {
					a = { fg = p.dim_blue, bg = p.alt_bg },
					b = { fg = p.dim_blue, bg = p.alt_bg },
					c = { fg = p.dim_blue, bg = p.bg },
				},
			},
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
					function()
						if vim.tbl_contains(prose_filetypes, vim.bo.filetype) then
							return require("nvim-prose").word_count()
						end
						return "progress"
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
		{ "<leader>b", group = "Buffers" },
	})
	wk.add({
		{ "<leader>f", group = "Telescope" },
	})
	wk.add({
		{ "<leader>d", group = "Debug" },
	})
	wk.add({
		{ "<leader>g", group = "Git" },
	})
	wk.add({
		{ "<leader>l", group = "LaTeX" },
	})
	vim.keymap.set("n", "?", function()
		wk.show({ global = true })
	end, { desc = "All Keymaps" })

	vim.keymap.set("n", "<leader>?", function()
		wk.show({ global = false })
	end, { desc = "Local Keymaps" })
end

function M.image()
	require("image").setup({
		backend = "kitty", -- or "ueberzug" or "sixel"
		processor = "magick_cli", -- or "magick_rock"
		integrations = {
			markdown = {
				enabled = true,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = false,
				only_render_image_at_cursor_mode = "popup", -- or "inline"
				floating_windows = false, -- if true, images will be rendered in floating markdown windows
				filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
			},
			asciidoc = {
				enabled = true,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = false,
				only_render_image_at_cursor_mode = "popup",
				floating_windows = false,
				filetypes = { "asciidoc", "adoc" },
			},
			neorg = {
				enabled = true,
				filetypes = { "norg" },
			},
			rst = {
				enabled = true,
			},
			typst = {
				enabled = true,
				filetypes = { "typst" },
			},
			html = {
				enabled = false,
			},
			css = {
				enabled = false,
			},
		},
		max_width = nil,
		max_height = nil,
		max_width_window_percentage = nil,
		max_height_window_percentage = 50,
		scale_factor = 1.0,
		kitty_direct_chunk_size = 4096, -- chunk size for direct Kitty graphics protocol transmission
		window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
		editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
		tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
		hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
	})
end

return M
