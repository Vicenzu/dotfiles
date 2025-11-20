local keymap = vim.keymap
return {
  'nvim-telescope/telescope.nvim',
  branch = "master",
  lazy = false,
  dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
      'nvim-tree/nvim-web-devicons',
      'andrew-george/telescope-themes',
  },

  config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.load_extension("fzf")
		telescope.load_extension("themes")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					},
				},
			},
    })
        keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>")
        keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")
        keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
        keymap.set("n", "<leader>fa", ":Telescope<CR>")
        keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
        keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
        keymap.set("n", "<leader>pr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end, { desc = "Find Connected Words under cursor" })
		keymap.set("n", "<leader>ths", "<cmd>Telescope themes<CR>", { noremap = true, silent = true, desc = "Theme Switcher" })
    end

  }
