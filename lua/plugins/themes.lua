local M = {}

local palettes = {
	dark = {
		bg = "#1D2230", -- Deep Navy
		fg = "#a5a296", -- Muted Stone
		alt_bg = "#282e3f", -- Mantle / Surface
		sel_bg = "#a5a296", -- Selection Highlight
		sel_fg = "#1D2230",
		cursor = "#80a961", -- Sage Green

		-- ANSI 16 Matchers
		red = "#c46b6b",
		green = "#80a961",
		yellow = "#D9B36C",
		blue = "#7489ab",
		dim_blue = "#668799",
		magenta = "#7E6BC4",
		cyan = "#5e8d8d",
		alt_cyan = "#7ba2a2",
		bright_fg = "#EAE6DA",
	},
	light = {
		bg = "#EAE6DA", -- Parchment White
		fg = "#394260", -- Ink Blue
		alt_bg = "#dcd8ca", -- Dim Parchment
		sel_bg = "#394260", -- Selection Highlight
		sel_fg = "#EAE6DA",
		cursor = "#394260", -- Ink Blue Focus

		-- ANSI 16 Matchers
		red = "#a14d4d",
		green = "#5a7a41",
		yellow = "#a68546",
		blue = "#7489ab",
		dim_blue = "#668799",
		magenta = "#5e4da1",
		cyan = "#5e8d8d",
		alt_cyan = "#7ba2a2",
		bright_fg = "#1D2230",
	},
}

local function get_active_theme_name()
	return vim.g.current_color_theme or "dark"
end

_G.theme_colors = {
	get_active_theme = function()
		return get_active_theme_name()
	end,
	get_palette = function()
		return palettes[get_active_theme_name()]
	end,
	get_theme_based_value = function(dark_val, light_val)
		return get_active_theme_name() == "dark" and dark_val or light_val
	end,
	get_badge_colors = function(component)
		local is_dark = get_active_theme_name() == "dark"
		local p = palettes[is_dark and "dark" or "light"]
		if component == "theme" then
			return { fg = p.bg, bg = p.blue, bold = true }
		else
			return { fg = p.bg, bg = p.green, bold = true }
		end
	end,
}

function M.apply_theme(theme_name)
	if not palettes[theme_name] then
		return
	end
	vim.g.current_color_theme = theme_name

	local p = palettes[theme_name]
	vim.opt.background = theme_name

	-- Clear out old highlight profiles safely
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "bogos-" .. theme_name

	-- Helper closure to rapidly assign Vim namespaces
	local hi = function(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- Core Vim Text Layers
	hi("Normal", { fg = p.fg, bg = p.bg })
	hi("NormalFloat", { fg = p.fg, bg = p.alt_bg })
	hi("Comment", { fg = p.dim_blue, italic = true })
	hi("CursorLine", { bg = p.alt_bg })
	hi("CursorColumn", { bg = p.alt_bg })
	hi("ColorColumn", { bg = p.alt_bg })
	hi("Visual", { fg = p.sel_fg, bg = p.sel_bg })
	hi("Search", { fg = p.bg, bg = p.yellow, bold = true })
	hi("IncSearch", { fg = p.bg, bg = p.cursor, bold = true })

	-- Borders and Dividers
	hi("WinSeparator", { fg = p.alt_bg, bg = p.bg })
	hi("LineNr", { fg = p.alt_bg })
	hi("CursorLineNr", { fg = p.cursor, bold = true })
	hi("FloatBorder", { fg = p.alt_bg, bg = p.alt_bg })
	hi("FloatTitle", { fg = p.blue, bg = p.alt_bg, bold = true })

	-- Generic Code Syntax Architecture
	hi("Constant", { fg = p.magenta })
	hi("String", { fg = p.cursor })
	hi("Character", { fg = p.cursor })
	hi("Number", { fg = p.magenta })
	hi("Boolean", { fg = p.magenta, bold = true })
	hi("Float", { fg = p.magenta })

	hi("Identifier", { fg = p.bright_fg })
	hi("Function", { fg = p.blue, bold = true })
	hi("Statement", { fg = p.green, bold = true })
	hi("Conditional", { fg = p.green, italic = true, bold = true })
	hi("Repeat", { fg = p.green, bold = true })
	hi("Label", { fg = p.blue })
	hi("Operator", { fg = p.fg })
	hi("Keyword", { fg = p.green, bold = true })
	hi("Exception", { fg = p.red, bold = true })

	hi("PreProc", { fg = p.magenta })
	hi("Type", { fg = p.yellow, italic = true })
	hi("Structure", { fg = p.yellow, bold = true })
	hi("Special", { fg = p.alt_cyan })
	hi("Todo", { fg = p.bg, bg = p.yellow, bold = true })

	-- TreeSitter Token Shims
	hi("@variable", { fg = p.fg })
	hi("@variable.builtin", { fg = p.red, italic = true })
	hi("@keyword", { link = "Keyword" })
	hi("@function", { link = "Function" })
	hi("@comment", { link = "Comment" })
	hi("@constant", { link = "Constant" })

	-- UI Component Interventions (Blink, Telescope, Neo-tree)
	hi("BlinkCmpMenu", { bg = p.alt_bg, fg = p.fg })
	hi("BlinkCmpMenuBorder", { fg = p.alt_bg, bg = p.alt_bg })
	hi("BlinkCmpMenuSelection", { bg = p.sel_bg, fg = p.sel_fg, bold = true })
	hi("BlinkCmpDoc", { bg = p.alt_bg, fg = p.fg })
	hi("BlinkCmpDocBorder", { fg = p.alt_bg, bg = p.alt_bg })
	hi("BlinkCmpSignatureHelp", { bg = p.alt_bg, fg = p.fg })
	hi("BlinkCmpSignatureHelpBorder", { fg = p.alt_bg, bg = p.alt_bg })

	hi("TelescopeNormal", { bg = p.alt_bg, fg = p.fg })
	hi("TelescopeBorder", { fg = p.alt_bg, bg = p.alt_bg })
	hi("TelescopeSelection", { bg = p.bg, fg = p.bright_fg, bold = true })
	hi("TelescopeMatching", { fg = p.cursor, bold = true })

	hi("NeoTreeNormal", { bg = p.alt_bg, fg = p.fg })
	hi("NeoTreeNormalNC", { bg = p.alt_bg, fg = p.fg })
	hi("NeoTreeWinSeparator", { fg = p.bg, bg = p.bg })

	hi("IblIndent", { fg = p.alt_bg })
	hi("IblScope", { fg = p.dim_blue })

	-- Native Terminal Grid Pipeline Mapping
	vim.g.terminal_color_0 = p.bg
	vim.g.terminal_color_8 = p.alt_bg
	vim.g.terminal_color_1 = p.red
	vim.g.terminal_color_9 = p.red
	vim.g.terminal_color_2 = p.green
	vim.g.terminal_color_10 = p.green
	vim.g.terminal_color_3 = p.yellow
	vim.g.terminal_color_11 = p.yellow
	vim.g.terminal_color_4 = p.blue
	vim.g.terminal_color_12 = p.dim_blue
	vim.g.terminal_color_5 = p.magenta
	vim.g.terminal_color_13 = p.magenta
	vim.g.terminal_color_6 = p.cyan
	vim.g.terminal_color_14 = p.alt_cyan
	vim.g.terminal_color_7 = p.fg
	vim.g.terminal_color_15 = p.bright_fg

	-- Hot-reload connected plugins
	if package.loaded["lualine"] then
		require("lualine").reset_highlights()
	end
	vim.cmd("redraw!")
end

-- Expose simple global toggle for manual user manipulation
_G.toggle_color_theme = function()
	local next_map = { dark = "light", light = "dark" }
	M.apply_theme(next_map[get_active_theme_name()])
end

vim.opt.shortmess:append("q")

-- Defaults straight to BogOS Dark variant on launch
M.apply_theme("dark")

return M
