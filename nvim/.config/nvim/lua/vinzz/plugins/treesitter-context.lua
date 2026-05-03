return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesitter-context").setup({
      enable = true, -- Abilita il plugin
      max_lines = 3, -- Quante righe di contesto mostrare al massimo in cima
      trim_scope = 'outer', -- Taglia i contesti più esterni se superi max_lines
      mode = 'cursor',  -- Calcola il contesto in base al cursore
    })
  end
}
