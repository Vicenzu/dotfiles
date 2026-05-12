return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		lint.linters_by_ft = {
			javascript = { "biomejs" },
			typescript = { "biomejs" },
			javascriptreact = { "biomejs" },
			typescriptreact = { "biomejs" },
			svelte = { "biomejs" },
			-- python = { "pylint" },  -- Da problemi
			java = { "checkstyle" },
			c = { "clangtidy" },
			cpp = { "clangtidy" },
		}

		lint.linters.checkstyle = {
			cmd = "checkstyle", -- Deve essere nel PATH (Mason o manuale)
			stdin = false,
			args = function()
				return {
					"-c",
					vim.fn.stdpath("data") .. "/checkstyle/google_checks.xml", -- Percorso locale dopo download
					vim.fn.expand("%:p"),
				}
			end,
			stream = "stdout",
			ignore_exitcode = true,
			parser = require("lint.parser").from_errorformat([[%f:%l:%c: %m]], { source = "checkstyle" }),
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "LspAttach" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

	end,
}
