return {
	-- ==========================
	-- MASON
	-- ==========================
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "→",
					package_uninstalled = "✗",
				},
			},
		},
	},
	-- ==========================
	-- MASON-LSPCONFIG
	-- ==========================
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"emmet_language_server",
					"denols",
					"asm_lsp",
					"ts_ls",
					"sqlls",
					"omnisharp",
					"basedpyright",
					"intelephense",
					"clangd",
					"marksman",
				},
			})
		end,
	},

	{
		"rshkarin/mason-nvim-lint",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-lint" },
		config = function()
			require("mason-nvim-lint").setup({
				ensure_installed = { "biomejs" },
				automatic_installation = { exclude = { "clangtidy", "checkstyle" } },
			})
		end,
	},
}
