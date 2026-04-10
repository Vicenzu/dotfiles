return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua", "java", "javascript", "typescript",
                "tsx", "jsx", "html", "css", "python",
                "c", "cpp", "markdown", "markdown_inline",
                "json", "yaml", "sql", "bash", "asm",
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
