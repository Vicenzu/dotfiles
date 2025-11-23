return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "Undotree Toggle" })
        vim.keymap.set("n", "<leader>rr", ':redo<CR>', { desc = "Redo" })
    end,
}
