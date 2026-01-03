return {
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
}
