return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  -- 'main' dice a Lazy quale modulo usare per la funzione di setup
  main = "nvim-treesitter.configs",
  -- 'opts' passa automaticamente questi parametri al setup() del plugin
  opts = {
    ensure_installed = {
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "markdown",
      "markdown_inline",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "java",
      "c",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    autotag = { enable = true },
  },
}
