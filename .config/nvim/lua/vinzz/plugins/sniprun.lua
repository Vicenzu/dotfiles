return {
    "michaelb/sniprun",
    build = "sh install.sh",
    config = function()
        require("sniprun").setup({
        display = {
            -- "Classic", -- Output sotto il codice
            "VirtualTextOk", "VirtualTextErr" -- per output inline
        },
        interpreter_options = {
            Java_original = {
            extension = ".java",
            },
        },
        })
    end,
}
