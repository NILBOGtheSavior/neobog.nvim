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
	"https://github.com/3rd/image.nvim",

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context", version = "master" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },

	-- Tools (Future: DAP and TESTING)
	-- Debugging
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/leoluz/nvim-dap-go",
	"https://github.com/theHamsta/nvim-dap-virtual-text",

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
	{
		mod = "ui",
		fn = "image",
		event = "UIEnter",
		packadd = { "image.nvim" },
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

	{
		mod = "debug",
		keys = {
			{ "<F5>", desc = "Debug Continue" },
			{ "<F1>", desc = "Debug Step Into" },
			{ "<F2>", desc = "Debug Step Over" },
			{ "<F3>", desc = "Debug Step Out" },
			{ "<F7>", desc = "Debug UI" },
			{ "<leader>db", desc = "Debug Breakpoint" },
			{ "<leader>dB", desc = "Debug Conditional BP" },
			{ "<leader>dx", desc = "Debug Clear BPs" },
			{ "<leader>dC", desc = "Debug Run to Cursor" },
			{ "<leader>dl", desc = "Debug Run Last" },
			{ "<leader>dt", desc = "Debug Terminate" },
			{ "<leader>dp", desc = "Debug Pause" },
			{ "<leader>dv", desc = "Debug Hover Toggle" },
			{ "<leader>dr", desc = "Debug REPL Eval" },
			{ "<leader>dfc", desc = "Debug Continue" },
			{ "<leader>dfi", desc = "Debug Step Into" },
			{ "<leader>dfO", desc = "Debug Step Over" },
			{ "<leader>dfo", desc = "Debug Step Out" },
			{ "<leader>dfu", desc = "Debug UI Toggle" },
			{ "<leader>dir", desc = "Debug REPL" },
			{ "<leader>dis", desc = "Debug Session" },
			{ "<leader>diw", desc = "Debug Widget Hover" },
			{ "<leader>diW", desc = "Debug Widget Scopes" },
			{ "<leader>diE", desc = "Debug Eval", mode = { "n", "v" } },
			{ "<leader>dgt", desc = "Debug Go Test" },
			{ "<leader>dgl", desc = "Debug Go Last Test" },
		},
		packadd = { "nvim-dap", "nvim-dap-ui", "nvim-nio", "nvim-dap-go", "nvim-dap-virtual-text" },
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
