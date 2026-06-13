local native = require("core.native")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<C-t>", "<cmd>split term:///bin/zsh<CR>i", { desc = "Open terminal" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics" })

-- navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- lazygit
vim.keymap.set("n", "<leader>gg", native.lazygit, { desc = "Toggle Lazygit" })
vim.keymap.set("n", "<leader>gl", native.lazygit_log, { desc = "Toggle Git Log for File" })
vim.keymap.set("n", "<leader>ft", native.terminal_float, { desc = "Toggle Float Terminal" })

-- buffers
vim.keymap.set("n", "<leader>bd", native.bufdelete, { desc = "Safe Delete Buffer" })
vim.keymap.set("n", "<leader>bD", native.bufdelete_force, { desc = "Force Safe Delete Buffer" })
vim.keymap.set("n", "<leader>bo", native.bufdelete_other, { desc = "Delete All Other Buffers" })

-- utilities
vim.keymap.set("n", "<leader>gb", native.gitbrowse, { desc = "Open File in Remote Browser" })
vim.keymap.set("n", "<leader>ns", native.scratch, { desc = "Toggle Filetype Scratchpad" })
vim.keymap.set("n", "<leader>nS", native.scratch_select, { desc = "Select Existing Scratchpads" })
