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

	-- Library enhancements

	require("lazydev").setup({
		library = { { path = "blink.cmp", words = { "blink" } } },
	})

	-- Blink.cmp integration

	local has_blink, blink = pcall(require, "blink.cmp")
	if has_blink then
		vim.lsp.config("*", {
			capabilities = blink.get_lsp_capabilities(),
		})
	end

	local lsp_dir = vim.fn.stdpath("config") .. "/lua/core/lsp"
	local enabled_servers = {}

	local handle = vim.uv.fs_scandir(lsp_dir)
	if handle then
		while true do
			local name, fs_type = vim.uv.fs_scandir_next(handle)
			if not name then
				break
			end

			if fs_type == "file" and name:match("%.lua$") then
				local server_name = name:gsub("%.lua$", "")

				local has_opts, opts = pcall(require, "core.lsp." .. server_name)
				if has_opts and type(opts) == "table" then
					vim.lsp.config[server_name] = opts
				end

				table.insert(enabled_servers, server_name)
			end
		end
	end

	if #enabled_servers > 0 then
		vim.lsp.enable(enabled_servers)
	end
end

return M
