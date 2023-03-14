return {
	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "stable", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "nightly", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		auto_quit = false, -- automatically quit the current session after a successful update
	},

	colorscheme = "tokyonight-storm",

	-- Diagnostics configuration (for vim.diagnostics.config({...}))
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	-- Extend LSP configuration
	lsp = {
		setup_handlers = {
			rust_analyzer = function(_, opts)
				require("rust-tools").setup({
					server = opts,
					tools = {
						inlay_hints = {
							parameter_hinds_prefis = "  ",
							other_hints_preifx = "  ",
						},
					},
				})
			end,
		},

		formatting = {
			filter = function(client)
				if client.name == "tsserver" then
					return false
				end

				return true
			end,
			format_on_save = true,
		},
	},

	polish = function() end,
}
