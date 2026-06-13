-- ====================================
-- = Plugins                          =
-- ====================================

vim.pack.add({

	-- Colorscheme
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

	-- Formatting
	"https://github.com/windwp/nvim-autopairs",

	-- Navigation
	"https://github.com/nvim-neo-tree/neo-tree.nvim",

	-- UI
	"https://github.com/nvim-lualine/lualine.nvim",
}, { confirm = false, load = function() end })

-- =============================================================================
-- Fields:
--   {
--  mod     = 'domain_file', -- e.g., 'ui' (maps to lua/plugins/ui.lua)
--  fn      = 'function',    -- (Optional) e.g., 'which_key' (calls M.which_key())
--  packadd = { 'plugin' },  -- Array of plugin dir names to :packadd before loading
-- Trigger (choose ONE):
--  event   = 'UIEnter',     -- Autocmd event(s) (string or array)
--  pattern = {'*.rs'},      -- (Optional) autocmd pattern; nil means all files
--  keys    = { ... },       -- Array of { '<leader>x', desc = '...', mode = 'n' }
--  defer   = 1,             -- Milliseconds to delay via vim.defer_fn
-- }
-- =============================================================================

local pack = require("core.pack")

pack.setup({
	-- Instant
	{ mod = "themes", packadd = { "catppuccin" } },

	-- Post
	{
		mod = "ui",
		fn = "statusline",
		event = "UIEnter",
		packadd = { "lualine.nvim", "nvim-web-devicons", "nvim-prose" },
	},

	-- On Call
	{
		mod = "navigation",
		fn = "neo_tree",
		event = "UIEnter",
		packadd = { "neo-tree.nvim", "nui.nvim", "plenary.nvim" },
	},
})
