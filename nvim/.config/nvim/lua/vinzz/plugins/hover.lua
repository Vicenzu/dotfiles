return {
  "lewis6991/hover.nvim",
  event = "VeryLazy",
  config = function()
    require("hover").setup({
      init = function()
        require("hover.providers.lsp")
        require("hover.providers.diagnostic")
        require("hover.providers.man")
      end,
      preview_opts = { border = "rounded" },
    })
  end
}
