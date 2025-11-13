return {
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
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"omnisharp",
					"basedpyright",
					"jdtls",
					"clangd",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
			})

			local on_attach = function(client, bufnr)
				--Shortcuts
				vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			end

			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = { diagnostics = { globals = { "vim" } } },
				},
			})

			vim.lsp.config("basedpyright", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("clangd", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("omnisharp", {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- jdtls (serve cmd/root_dir, altrimenti non parte)
			local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
			local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
			local config_dir = jdtls_path .. "/config_linux"
			local workspace_dir = vim.fn.stdpath("data")
				.. "/jdtls-workspace/"
				.. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

			vim.lsp.config("jdtls", {
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = {
					"java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xms1g",
					"-Xmx2G",
					"-jar",launcher_jar,
					"-configuration", config_dir,
					"-data", workspace_dir,
				},
				root_dir = vim.fs.dirname(
					vim.fs.find({ ".git", "pom.xml", "build.gradle" }, { upward = true })[1] or vim.loop.cwd()
				),
			})
			vim.lsp.enable("basedpyright")
			vim.lsp.enable("omnisharp")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("jdtls")
			vim.lsp.enable("clangd")
		end,
	},
}
