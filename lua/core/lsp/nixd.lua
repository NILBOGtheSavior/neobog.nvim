return {
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", "configuration.nix", ".git" },
    settings = {
        nixd = {
            formatting = {
                command = { "nixpkgs-fmt" },
            },
        },
    },
}
