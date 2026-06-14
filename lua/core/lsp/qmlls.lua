return {
	cmd = { "qmlls6" },
	filetypes = { "qml" },
	root_markers = { "qmlls.ini", ".qmlls.build.ini", ".git" },
	capabilities = capabilities,

	init_options = {
		importPaths = {
			"/usr/lib/qt6/qml",
		},
	},

	on_attach = function(client, bufnr)
		client.server_capabilities.semanticTokensProvider = nil
	end,
}
