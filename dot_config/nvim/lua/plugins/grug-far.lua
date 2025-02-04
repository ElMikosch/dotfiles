return {
	{
		"MagicDuck/grug-far.nvim",
		config = function()
			require("grug-far").setup({
				-- options, see Configuration section below
				vim.keymap.set("n", "<leader>F", ":GrugFar<CR>"),
				-- there are no required options atm
				-- engine = 'ripgrep' is default, but 'astgrep' can be specified
			})
		end,
	},
}
