vim.cmd([[set mouse=]])
vim.cmd([[set noswapfile]])

vim.opt.winborder = "rounded"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect"
vim.g.mapleader = " "

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/chentoast/marks.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/LinArcX/telescope-env.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/sidekick.nvim" },
	{ src = "https://github.com/github/copilot.vim" },
})

require("marks").setup({
	builtin_marks = { "<", ">", "^" },
	refresh_interval = 250,
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	excluded_filetypes = {},
	excluded_buftypes = {},
	mappings = {},
})

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

require("mason").setup()

require("telescope").setup({
	defaults = {
		preview = { treesitter = false },
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = { "", "", "", "", "", "", "", "" },
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40,
		},
	},
})

require("actions-preview").setup({
	backend = { "telescope" },
	extensions = { "env" },
	telescope = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {}),
})

vim.lsp.enable({
	"lua_ls",
	"copilot",
	"basedpyright",
	"zls",
	"clangd",
	"gdscript",
})

require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local disable_filetypes = { c = false }
		local lsp_format_opt
		if disable_filetypes[vim.bo[bufnr].filetype] then
			lsp_format_opt = "never"
		else
			lsp_format_opt = "fallback"
		end
		return {
			timeout_ms = 500,
			lsp_format = lsp_format_opt,
		}
	end,
	formatters_by_ft = {
		lua = { "stylua" },
	},
})

require("nvim-treesitter").setup({
	ensure_installed = { "lua", "python", "javascript", "typescript", "tsx", "html", "css", "json", "yaml", "bash" },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})

require("blink-cmp").setup({
	keymap = {
		preset = "default",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		menu = {
			draw = {
				treesitter = { "lsp" },
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		ghost_text = {
			enabled = false,
		},
	},
	signature = { enabled = true, window = { show_documentation = true } },
	fuzzy = { implementation = "lua" },
})

require("oil").setup({
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"permissions",
		"icon",
	},
	float = {
		max_width = 0.7,
		max_height = 0.6,
		border = "rounded",
	},
	keymaps = { ["<Esc>"] = "actions.close" },
})

require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()

require("sidekick").setup({})

require("vague").setup({ transparent = true })
vim.cmd("colorscheme vague")
require("luasnip").setup({ enable_autosnippets = true })

local builtin = require("telescope.builtin")
local map = vim.keymap.set

local function apply_nes()
	if require("sidekick").nes_jump_or_apply() then
		return -- jumped or applied
	end

	if vim.lsp.inline_completion.get() then
		return
	end

	return "<tab>"
end

map({ "n" }, "<leader>f", builtin.find_files, { desc = "Telescope live grep" })
map({ "n" }, "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
map({ "n" }, "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
map({ "n" }, "<leader>si", builtin.grep_string, { desc = "Telescope live string" })
map({ "n" }, "<leader>so", builtin.oldfiles, { desc = "Telescope buffers" })
map({ "n" }, "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })
map({ "n" }, "<leader>sm", builtin.man_pages, { desc = "Telescope man pages" })
map({ "n" }, "<leader>sr", builtin.lsp_references, { desc = "Telescope tags" })
map({ "n" }, "<leader>st", builtin.builtin, { desc = "Telescope tags" })
map({ "n" }, "<leader>sd", builtin.registers, { desc = "Telescope tags" })
map({ "n" }, "<leader>sc", builtin.colorscheme, { desc = "Telescope tags" })
map({ "n" }, "gd", builtin.lsp_definitions)
map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>", { desc = "Telescope tags" })
map({ "n" }, "gra", require("actions-preview").code_actions)
map({ "n" }, "<leader>e", "<cmd>Oil<CR>")
map({ "n" }, "<leader>gg", vim.cmd.Git)
map({ "n" }, "<leader>u", vim.cmd.UndotreeToggle)
map({ "i", "n" }, "<tab>", apply_nes, { expr = true, silent = true })
-- map({ "i", "n" }, "<leader>c", require("sidekick.nes").clear)
map({ "n" }, "<leader>aa", require("sidekick.cli").toggle)
map({ "n", "x" }, "<leader>ap", require("sidekick.cli").prompt)
map({ "x" }, "<leader>av", function()
	require("sidekick.cli").send("{position}")
end)

map({ "n" }, "<Esc>", "<cmd>nohlsearch<CR>")
map({ "n" }, "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
map({ "t" }, "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map({ "n" }, "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map({ "n" }, "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map({ "n" }, "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map({ "n" }, "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("elmikosch-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
