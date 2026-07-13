return {
	"lervag/vimtex",
	lazy = false, -- deve caricare prima di aprire un file .tex
	init = function()
		-- compilatore: latexmk gestisce da solo bibtex/passate multiple/\input
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			build_dir = "",
			callback = 1,
			continuous = 1,
			executable = "latexmk",
			options = {
				"-pdf",
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}

		-- viewer: zathura con SyncTeX (click nel pdf -> riga sorgente e viceversa)
		vim.g.vimtex_view_method = "general"
		vim.g.vimtex_view_general_viewer = "okular"
		vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"

		-- quickfix: mostra solo errori veri, non warning rumorosi dei pacchetti
		vim.g.vimtex_quickfix_mode = 2
		vim.g.vimtex_quickfix_open_on_warning = 0
		vim.g.vimtex_quickfix_ignore_filters = {
			"Underfull",
			"Overfull",
			"Package hyperref Warning",
			"Package caption Warning",
		}

		-- niente folding automatico dei vimtex (usiamo quello di treesitter se serve)
		vim.g.vimtex_fold_enabled = 0

	end,
	config = function()
		local map = vim.keymap.set
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "tex",
			callback = function(args)
				local opts = { buffer = args.buf, silent = true }
				map("n", "<leader>lb", "<cmd>VimtexCompile<CR>", vim.tbl_extend("force", opts, { desc = "LaTeX: compila (watch)" }))
				map("n", "<leader>lv", "<cmd>VimtexView<CR>", vim.tbl_extend("force", opts, { desc = "LaTeX: apri PDF (zathura)" }))
				map("n", "<leader>ls", "<cmd>VimtexStop<CR>", vim.tbl_extend("force", opts, { desc = "LaTeX: stop compilazione" }))
				map("n", "<leader>le", "<cmd>VimtexErrors<CR>", vim.tbl_extend("force", opts, { desc = "LaTeX: mostra errori" }))
				map("n", "<leader>lt", "<cmd>VimtexTocToggle<CR>", vim.tbl_extend("force", opts, { desc = "LaTeX: indice (TOC)" }))
				map("n", "<leader>lc", "<cmd>VimtexClean<CR>", vim.tbl_extend("force", opts, { desc = "LaTeX: pulisci aux files" }))
			end,
		})
	end,
}
