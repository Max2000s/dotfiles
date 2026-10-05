-- ===============================
-- NVIM CONFIGURATION
-- ===============================

-- REMAPS
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)
vim.keymap.set("n", "<leader><leader>", "<CMD>Oil<CR>", { desc = "Open Oil file manager" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory in Oil" })

-- Disable Netrw (replaced by Oil)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- OPTIONS
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0

local undodir = vim.fn.expand("~/.nvim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.selection = "inclusive"
vim.opt.clipboard:append("unnamedplus")

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.diffopt:append("linematch:60")
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- PLUGINS
vim.pack.add{
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
	{ src = "https://github.com/saghen/blink.cmp", name = "blink.cmp" },
	{ src = "https://github.com/ibhagwan/fzf-lua", name = "fzf-lua" },
	{ src = "https://github.com/echasnovski/mini.nvim", name = "mini.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim", name = "oil" },
}

-- COLORSCHEME
vim.opt.termguicolors = true
vim.cmd.colorscheme("rose-pine")

-- ICONS (mini.icons)
require("mini.icons").setup({})

-- FILE EXPLORER (oil.nvim)
require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
	},
})

-- AUTOCOMPLETION (blink.cmp)
require("blink.cmp").setup({
	keymap = {
		preset = "super-tab",
		["<CR>"] = { "accept", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
})

-- FUZZY FINDER (fzf-lua)
local fzf = require("fzf-lua")
fzf.setup({})
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })

-- LSP
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Rust
vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				features = "all",
			},
			check = {
				command = "clippy",
			},
			imports = {
				group = {
					enable = false,
				},
			},
			completion = {
				postfix = {
					enable = false,
				},
			},
		},
	},
})
vim.lsp.enable("rust_analyzer")

-- Bash LSP
if vim.fn.executable("bash-language-server") == 1 then
	vim.lsp.enable("bashls")
end

-- STATUSLINE
require("statusline")
