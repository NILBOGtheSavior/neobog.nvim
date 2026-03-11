return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
	  spec = {
		  { '<leader>f', group = 'Telescope' },
	  },
  },
  keys = {
    {
      "?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "All keymaps",
    },
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
}
