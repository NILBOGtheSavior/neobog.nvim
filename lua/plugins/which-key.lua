return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		keys = {
			scroll_down = "<c-n>",
			scroll_up = "<c-b>",
		},

		spec = {
			{ "<leader>f", group = "Telescope" },
		},
	},
	keys = {

		{
			"?",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "All keymaps",
		},
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps",
		},
	},
}
