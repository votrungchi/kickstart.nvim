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
  {
    'github/copilot.vim',
    event = 'InsertEnter',
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    cmd = { 'CopilotChat', 'CopilotChatOpen', 'CopilotChatToggle' },
    config = function()
      require('CopilotChat').setup {
        show_help = false, -- hide inline help if desired
        headers = {
          user = '👷Chi Vo',
          assistant = '🤡Copilot',
        },
      }
    end,
    vim.keymap.set('n', '<leader>cc', function()
      require('CopilotChat').toggle()
    end, { desc = 'Toggle CopilotChat' }),
  },
  {
    'f-person/git-blame.nvim',
    opts = {
      enabled = true,
      message_template = ' <author> • <date> • <summary>',
      date_format = '%Y-%m-%d',
      virtual_text_column = 80,
    },
  },
  -- lua/plugins/mini-map.lua
  {
    'nvim-mini/mini.map',
    version = false, -- use latest (main). For pinned releases, set version = '*'
    config = function()
      local map = require 'mini.map'

      map.setup {
        -- Show search, diagnostics, and Git hunks if available
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diagnostic(),
          -- Enable one or both of the following if you use them:
          -- require('mini.diff') and its integration
          map.gen_integration.diff(), -- needs mini.diff enabled
          -- Gitsigns integration (plugin optional)
          map.gen_integration.gitsigns(),
        },
        symbols = {
          -- keep defaults; or choose different resolution with:
          encode = map.gen_encode_symbols.dot '3x2',
          scroll_line = '█',
          scroll_view = '┃',
        },
        window = {
          side = 'right',
          width = 25,
          winblend = 25,
          focusable = true,
          show_integration_count = true,
          zindex = 10,
        },
      }

      -- Keymaps similar to MiniMap’s help
      vim.keymap.set('n', '<leader>mm', map.toggle, { desc = 'MiniMap toggle' })
      vim.keymap.set('n', '<leader>mo', map.open, { desc = 'MiniMap open' })
      vim.keymap.set('n', '<leader>mc', map.close, { desc = 'MiniMap close' })
      vim.keymap.set('n', '<leader>mr', map.refresh, { desc = 'MiniMap refresh' })
      vim.keymap.set('n', '<leader>ms', map.toggle_side, { desc = 'MiniMap side' })
      vim.keymap.set('n', '<leader>mf', map.toggle_focus, { desc = 'MiniMap focus' })

      -- Optional: auto-open on start (Kickstart starts in a real buffer)
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          -- Skip when no file/buffer (like a dashboard); adjust to your setup
          if vim.bo.buftype == '' then
            map.open()
          end
        end,
      })
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
}
