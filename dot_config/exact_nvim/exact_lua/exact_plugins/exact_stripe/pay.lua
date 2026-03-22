return {
	url = "https://git.corp.stripe.com/iheanyi/pay.nvim",
	dependencies = { "stevearc/overseer.nvim" },
	opts = {
		-- Autogen keeps rebooting. Disabling it for now.
		autogen = {
			auto_watch = false,
		},
	},
}
