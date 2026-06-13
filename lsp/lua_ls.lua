return {
	cmd = { "lua-language-server" },
	root_markers = { ".luarc.json", ".git" },
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enabled = false },
		},
	},
}
