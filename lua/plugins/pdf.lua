return {
	{
		"arminveres/md-pdf.nvim",
		branch = "main",
		lazy = true,
		ft = { "markdown" },
		keys = {
			{
				"<leader>,",
				function()
					require("md-pdf").convert_md_to_pdf()
				end,
				desc = "Markdown preview",
			},
		},
		-- ---@type md-pdf.config
		opts = {
			margins = "1.5cm",
			highlight = "tango",
			toc = false,
			title_page = false,
			preview_cmd = function()
				return "zathura"
			end,
			ignore_viewer_state = false,
			pandoc_user_args = {
				"--mathml",
				"--webtex",
			},
			output_path = "./",
			pdf_engine = "pdflatex",
		},
	},
	{
		"lervag/vimtex",
		lazy = false,
		ft = { "tex" },
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end,
	},
}
