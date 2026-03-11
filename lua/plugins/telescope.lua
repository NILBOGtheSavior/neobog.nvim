return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
	},
}
