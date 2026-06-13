require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = {
		nerd_font_variant = "mono",
		kind_icons = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "󰜢",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "󰈇",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "󰙅",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "",
		},
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		per_filetype = {
			lua = { "lazydev", "lsp", "path", "snippets", "buffer" },
		},
		providers = {
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},
	fuzzy = {
		implementation = "prefer_rust",
	},
	signature = {
		enabled = true,
	},
})
