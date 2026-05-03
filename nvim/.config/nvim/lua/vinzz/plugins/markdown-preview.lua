return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    -- Cambia il build da npm a questo:
    build = function()
        vim.cmd("call mkdp#util#install()")
    end,
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_auto_close = 1
        vim.g.mkdp_browser = ""  -- usa il browser di default del sistema
    end,
    ft = { "markdown" },
}
