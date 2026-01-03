-- Global editing options
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local cur = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[%s/\s\+$//e]]
    pcall(vim.api.nvim_win_set_cursor, 0, cur)
  end,
})

return {
  -- {
  --   'f-person/git-blame.nvim',
  --   opts = {
  --     enabled = true,
  --     message_template = ' <author> • <date> • <summary>',
  --     date_format = '%Y-%m-%d',
  --     virtual_text_column = 80,
  --   },
  -- },
  -- lua/plugins/mini-map.lua
}
