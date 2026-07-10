return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	-- 'opts' passa automaticamente questi parametri al setup() del plugin
	opts = {
		ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"markdown",
			"markdown_inline",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"java",
			"c",
			"bash",
			"regex",
			"latex",
			"bibtex",
		},

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},

		indent = { enable = true },
	},
}
