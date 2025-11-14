return {
  {  'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find File"}) --ctrl+p ricerca file
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep"}) --space+fg ricerca parole
    end


  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown{}
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },
}
