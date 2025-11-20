return {
    "CRAG666/code_runner.nvim",
    lazy = false,
    config = function ()
        require('code_runner').setup({
            filetype = {
                java = {
                    "cd $dir &&",
                    "javac $fileName &&",
                    "java $fileNameWithoutExt"
                    -- [[cd $dir && ( while [ ! -f Makefile -a "$PWD" != "/" ]; do cd ..; done; if [ -f Makefile ]; then make run; else echo "Makefile non trovato"; fi )]]
                },
                python = "python3 -u",
                typescript = "deno run",
                rust = {
                    "cd $dir &&",
                    "rustc $fileName &&",
                    "$dir/$fileNameWithoutExt"
                },
                dart = "dart run",
                c = function(...)
                    c_base = {
                        "cd $dir &&",
                        "gcc $fileName -o",
                        "/tmp/$fileNameWithoutExt",
                    }
                    local c_exec = {
                        "&& /tmp/$fileNameWithoutExt &&",
                        "rm /tmp/$fileNameWithoutExt",
                    }
                    vim.ui.input({ prompt = "Add more args:" }, function(input)
                        c_base[4] = input
                        vim.print(vim.tbl_extend("force", c_base, c_exec))
                        require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
                    end)
                end,
            },
        })
    end,
    keys = {
        vim.keymap.set('n', '<leader>rr', ':RunCode<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false }),
    },
}
