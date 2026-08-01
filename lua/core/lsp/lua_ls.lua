return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".git" },
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enabled = false },
        },
    },
}
