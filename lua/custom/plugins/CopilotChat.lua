return {
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
}
