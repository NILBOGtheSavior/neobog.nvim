-- ====================================
-- = Plugins                          =
-- ====================================

vim.pack.add({

	-- Colorscheme
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

	-- Formatting
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/stevearc/conform.nvim",

	-- Navigation
	"https://github.com/nvim-neo-tree/neo-tree.nvim",

	-- UI
	"https://github.com/nvim-lualine/lualine.nvim",

	-- Utils
    "https://github.com/saghen/blink.lib",
	"https://github.com/Saghen/blink.cmp",
}, { confirm = false, load = function() end })

local pack = require("core.pack")

pack.setup({
	-- Instant
	{ mod = "themes", packadd = { "catppuccin" } },

	-- Post
	{
		mod = "ui",
		fn = "statusline",
		event = "UIEnter",
		packadd = { "lualine.nvim", "nvim-web-devicons", "nvim-prose" },
	},

	-- On Keystroke
	{
		mod = "formatting",
		fn = "autopairs",
		event = { "InsertEnter", "CmdlineEnter" },
		packadd = { "nvim-autopairs" },
	},
	{ mod = "completion", event = { "InsertEnter", "CmdlineEnter" }, packadd = { "blink.lib", "blink.cmp" } },

	-- On Call
	{
		mod = "navigation",
		fn = "neo_tree",
		event = "UIEnter",
		packadd = { "neo-tree.nvim", "nui.nvim", "plenary.nvim" },
	},

	-- On Save
	{ mod = "formatting", fn = "conform", event = "BufWritePre", packadd = { "conform.nvim" } },
})
