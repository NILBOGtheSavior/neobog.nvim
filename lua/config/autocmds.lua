vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = vim.highlight.on_yank,
})

vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = function()
    vim.cmd.colorscheme(vim.g.colors_name)
  end,
})
