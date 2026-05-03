return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                numbers = "none",
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diag)
                    local icons = { error = " ", warning = " ", info = " " }
                    local ret = (diag.error and icons.error .. diag.error .. " " or "")
                        .. (diag.warning and icons.warning .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {{
                    filetype = "neo-tree",
                    text = "File Explorer",
                    highlight = "Directory",
                    separator = true,
                }},
                separator_style = "thin",
                show_buffer_close_icons = true,
                show_close_icon = false,
                color_icons = true,
            },
        })
    end,
}
