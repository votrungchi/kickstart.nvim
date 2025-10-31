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
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        contrast = 'hard',
      }
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
  { 'github/copilot.vim' },
  {
    'f-person/git-blame.nvim',
    opts = {
      enabled = true,
      message_template = ' <author> • <date> • <summary>',
      date_format = '%Y-%m-%d',
      virtual_text_column = 80,
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {}
      local Terminal = require('toggleterm.terminal').Terminal
      local cmd = Terminal:new { cmd = 'cmd.exe', direction = 'float', hidden = true }
      local gitbash = Terminal:new {
        cmd = '"C:/Program Files/Git/bin/bash.exe"',
        direction = 'float',
        hidden = true,
      }
      vim.keymap.set('n', '<leader>tc', function()
        cmd:toggle()
      end, { desc = 'Toggle CMD Terminal' })
      vim.keymap.set('n', '<leader>tg', function()
        gitbash:toggle()
      end, { desc = 'Toggle Git Bash Terminal' })
    end,
  },
  {
    'Isrothy/neominimap.nvim',
    version = 'v3.*',
    lazy = false,
    keys = { { '<leader>nm', '<cmd>Neominimap Toggle<cr>', desc = 'Toggle minimap' } },
    init = function()
      vim.g.neominimap = { auto_enable = true }
    end,
  },
}
