return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesitter-context").setup({
			enable = true,
			max_lines = 3,
			trim_scope = "outer",
			mode = "cursor",
			-- Aggiungi questo:
			multiline_threshold = 1,
			on_attach = function(buf)
				-- Disabilita su file Java molto grandi
				local line_count = vim.api.nvim_buf_line_count(buf)
				return line_count < 5000
			end,
		})
	end,
}
