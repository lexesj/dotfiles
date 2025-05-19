return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      }
    end,
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        { "<leader>pf", builtin.find_files, desc = "telescope find files" },
        { "<leader>pb", builtin.buffers,    desc = "telescope buffers" },
        { "<leader>ps", builtin.live_grep,  desc = "telescope live grep" },
        { "<C-p>",      builtin.git_files,  desc = "telescope git files" },
      }
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
}
