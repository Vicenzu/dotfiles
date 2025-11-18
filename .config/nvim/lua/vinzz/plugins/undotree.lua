return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "Undotree Toggle" })
        vim.keymap.set("n", "<leader>u", ':undo<CR>', { desc = "Undo" })
        vim.keymap.set("n", "<leader>r", ':redo<CR>', { desc = "Redo" })
    end,
}
