return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "→",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "omnisharp",
          "basedpyright",
          "jdtls",
          "clangd"
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      vim.lsp.enable("basedpyright")
      vim.lsp.enable("omnisharp")
      vim.lsp.enable("lua_ls");
      vim.lsp.enable("jdtls");
      vim.lsp.enable("clangd");

      --Shortcuts
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
