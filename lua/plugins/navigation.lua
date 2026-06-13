local M = {}

function M.neo_tree()
	require("neo-tree").setup({
		vim.keymap.set("n", "\\", "<Cmd>Neotree toggle<CR>", {
			desc = "Toggle Neo-tree File Explorer",
		}),
	})
end

function M.telescope()
	local telescope = require("telescope")
	local action = require("telescope.actions")
	telescope.setup({
		pickers = {
			colorscheme = {
				enable_preview = true,
			},
		},
	})
	pcall(telescope.load_extension, "fzf")
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
	vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
	vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "Select" })
end

return M
