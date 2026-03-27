return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("treesitter-context").setup({
      enable = true,
      max_lines = 4,          -- max righe di contesto mostrate in cima
      min_window_height = 20, -- non mostra il contesto su finestre piccole
      line_numbers = true,
      multiline_threshold = 1, -- max righe per un singolo contesto
      trim_scope = "outer",    -- "outer" | "inner"
      mode = "cursor",         -- "cursor" | "topline"
      separator = nil,         -- carattere separatore, es. "─" oppure nil
      zindex = 20,
    })
  end,
}
