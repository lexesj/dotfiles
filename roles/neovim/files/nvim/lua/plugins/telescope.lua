local builtin = require('telescope.builtin')

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { "<leader>pf", builtin.find_files, desc = "telescope find files" },
    { "<leader>pb", builtin.buffers, desc = "telescope buffers" },
    { "<leader>ps", builtin.live_grep, desc = "telescope live grep" },
    { "<C-p>", builtin.git_files, desc = "telescope git files" }
  }
}

