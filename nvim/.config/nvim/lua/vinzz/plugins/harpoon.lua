return {
    "thePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("harpoon"):setup({
            global_settings = {
                save_on_toggle = true,
                save_on_change = true,
            },
        })
    end,
}
