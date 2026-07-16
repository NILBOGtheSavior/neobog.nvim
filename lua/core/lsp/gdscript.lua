return {
	cmd = function(dispatchers)
		return vim.lsp.rpc.connect("127.0.0.1", 6005)(dispatchers)
	end,
	filetypes = { "gdscript" },
	root_markers = { "project.godot", ".git" },
}
