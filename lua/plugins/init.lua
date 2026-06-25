-- ====================================
-- = Plugins                          =
-- ====================================

vim.pack.add({

	-- Formatting
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/stevearc/conform.nvim",

	-- Navigation
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-neo-tree/neo-tree.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",

	-- UI
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/goolord/alpha-nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/skwee357/nvim-prose",
	"https://github.com/folke/which-key.nvim",

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context", version = "master" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },

	-- Tools (Future: DAP and TESTING)

	-- LSP
	"https://github.com/folke/lazydev.nvim",

	-- Utils
	"https://github.com/saghen/blink.lib",
	"https://github.com/Saghen/blink.cmp",
}, { confirm = false, load = function() end })

local pack = require("core.pack")

pack.setup({
	-- Instant
	{ mod = "themes", fn = "apply_theme" },
	{
		mod = "ui",
		fn = "splash",
		-- event = "VimEnter",
		packadd = { "alpha-nvim" },
	},

	-- Post
	{
		mod = "ui",
		fn = "statusline",
		event = "UIEnter",
		packadd = { "lualine.nvim", "nvim-web-devicons", "nvim-prose" },
	},

	-- On File
	{ mod = "treesitter", fn = "base", event = { "BufReadPre", "BufNewFile" }, packadd = { "nvim-treesitter" } },
	{
		mod = "lsp",
		fn = "setup",
		event = { "BufReadPre", "BufNewFile" },
		packadd = { "lazydev.nvim" },
	},
	{
		mod = "ui",
		fn = "gitsigns",
		event = { "BufReadPre", "BufNewFile" },
		packadd = { "gitsigns.nvim", "plenary.nvim" },
	},

	-- On Keystroke
	{
		mod = "formatting",
		fn = "autopairs",
		event = { "InsertEnter", "CmdlineEnter" },
		packadd = { "nvim-autopairs" },
	},
	{
		mod = "completion",
		event = { "InsertEnter", "CmdlineEnter" },
		packadd = { "lazydev.nvim", "blink.lib", "blink.cmp" },
	},
	{ mod = "ui", fn = "clue", event = { "UIEnter" }, packadd = { "which-key.nvim" } },
	{
		mod = "navigation",
		fn = "telescope",
		keys = {
			{ "<leader>ff", desc = "Find files" },
			{ "<leader>fg", desc = "Live grep" },
			{ "<leader>fb", desc = "Buffers" },
			{ "<leader>fh", desc = "Help tags" },
			{ "<leader>fd", desc = "Diagnostics" },
			{ "<leader>fs", desc = "Select" },
		},
		packadd = { "telescope.nvim", "telescope-fzf-native" },
	},

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
