return {
    'arminveres/md-pdf.nvim',
    branch = 'main',
    lazy = true,
    keys = {
        {
            "<leader>,",
            function() require("md-pdf").convert_md_to_pdf() end,
            desc = "Markdown preview",
        },
    },
    ---@type md-pdf.config
    opts = {
    margins = "1.5cm",
    highlight = "tango",
    toc = false,
    title_page = false,
    preview_cmd = function() return 'zathura' end,
    ignore_viewer_state = false,
    fonts = {
        main_font = nil,
        sans_font = "DejaVuSans",
        mono_font = "IosevkaTerm Nerd Font Mono",
        math_font = nil,
    },
    pandoc_user_args = nil,
    output_path = "",
    pdf_engine = "pdflatex",
    },
}
