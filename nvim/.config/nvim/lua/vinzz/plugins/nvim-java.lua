return {
	"nvim-java/nvim-java",
	config = function()
		require("java").setup({
			jdtls = {
				settings = {
					jvm_args = {
						"-javaagent:/usr/share/java/lombok.jar",
					},
				},
			},
		})
		vim.lsp.enable("jdtls")
	end,
}
