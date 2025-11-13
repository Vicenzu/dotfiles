return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,

        -- JS/TS/HTML/CSS
        null_ls.builtins.formatting.prettier.with({
          prefer_local = "node_modules/.bin",
        }),
        -- null_ls.builtins.diagnostics.eslint_d, -- abilita se hai eslint_d installato

        -- Ruby
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.formatting.rubocop,

        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
      },
    })

    -- format rapido
    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ async = false })
    end, { desc = "Format buffer (LSP / none-ls)" })
  end,
}

