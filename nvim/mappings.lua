return {
	n = {
		L = {
			function()
				require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
			end,
			desc = "Next buffer",
		},
		H = {
			function()
				require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
			end,
			desc = "Previous buffer",
		},
	},
	i = {
		["<C-J>"] = { "copilot#Accept()", silent = true, expr = true, desc = "Accept Copilot suggestion" },
	},
}
