return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls" },
			automatic_enable = true,
		},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						border = "rounded",
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
		config = function(_, opts)
			require("mason").setup(opts.mason)
			require("mason-lspconfig").setup(opts)
			if vim.lsp.config then
				vim.lsp.config("*", {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				})
			else
				local lspconfig = require("lspconfig")
				require("mason-lspconfig").setup_handlers({
					function(server)
						lspconfig[server].setup({})
					end,
				})
			end
		end,
	},
	{
		"scalameta/nvim-metals",
		ft = { "scala", "sbt", "java" },
		opts = function()
			local metals_config = require("metals").bare_config()
			metals_config.on_attach = function(client, bufnr)
				vim.diagnostic.config({
					virtual_text = true,
					update_in_insert = false,
				}, vim.api.nvim_create_namespace("metals"))
			end

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},
}
