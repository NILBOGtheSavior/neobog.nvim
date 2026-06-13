local M = {}

function M.autopairs()
    require("nvim-autopairs").setup({})
end

function M.conform()
    require("conform").setup({
        format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
		},
    })
end

return M
