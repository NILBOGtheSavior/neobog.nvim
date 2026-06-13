local M = {}

function M.setup()
	vim.diagnostic.config({
		virtual_text = { prefix = "■", spacing = 4 },
		float = { border = "single" },
		signs = true,
		update_in_insert = false,
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local opts = { buffer = bufnr, silent = true }

			-- Navigation
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition", buffer = bufnr })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration", buffer = bufnr })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation", buffer = bufnr })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to References", buffer = bufnr })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = bufnr })

			-- Refactoring Actions
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol", buffer = bufnr })
			vim.keymap.set(
				{ "n", "v" },
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ desc = "Code Action", buffer = bufnr }
			)

			-- Auto-format on save execution loop
			if client and client:supports_method("textDocument/formatting") then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr, async = false })
					end,
				})
			end
		end,
	})

	require("lazydev").setup({
		library = { { path = "blink.cmp", words = { "blink" } } },
	})

	vim.lsp.enable({ "lua_ls", "clangd" })
end

return M
