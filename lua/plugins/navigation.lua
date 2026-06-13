local M = {}

function M.neo_tree()
	require("neo-tree").setup({
		vim.keymap.set("n", "\\", "<Cmd>Neotree toggle<CR>", {
			desc = "Toggle Neo-tree File Explorer",
		}),
	})
end

return M
