return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Scaricati/", "~/Scrivania/", "~/Documents/" },
		})
	end,
}
