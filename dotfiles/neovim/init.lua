vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.loaded_netrwPlugin = 0

vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 15
vim.opt.jumpoptions = "stack,view"

vim.opt.wrap = false
vim.opt.linebreak = false

vim.opt.mouse = "a"
vim.opt.showmode = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = false

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"

vim.o.winborder = "rounded"
vim.o.langmap =
	"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = { current_line = true },
})

vim.keymap.set("n", "<C-_>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set("n", "<leader>lo", function()
	vim.opt.scrolloff = 999 - vim.o.scrolloff
end, { desc = "[LO]ck cursor in middle" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },

	-- Navigation
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/mikavilpas/yazi.nvim" },

	-- LSP
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	-- Completion
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lua" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },

	{ src = "https://github.com/stevearc/conform.nvim" },
	-- Starter dashboard
	{ src = "https://github.com/goolord/alpha-nvim" },
	-- Highlight special comments
	{ src = "https://github.com/folke/todo-comments.nvim" },
	-- Notifications
	{ src = "https://github.com/j-hui/fidget.nvim" },
	-- Highlight other uses of a word/object
	{ src = "https://github.com/RRethy/vim-illuminate" },
	{ src = "https://github.com/petertriho/nvim-scrollbar" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },

	-- Typst
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },

	-- Debug
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/igorlfs/nvim-dap-view" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },

	-- Zen
	{ src = "https://github.com/folke/twilight.nvim" },

	-- Search & Replace
	{ src = "https://github.com/MagicDuck/grug-far.nvim" },

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local color_bg = "#1b100f"
local color_text = "#da7890"
local color_text_dim = "#59313a"

require("mini.base16").setup({
	palette = {
		base00 = color_bg,
		base01 = "#2e1d1d",
		base02 = "#6b3844",
		base03 = color_text,
		base04 = "#805a5a",
		base05 = "#a87d7d",
		base06 = "#c4adad",
		base07 = "#e8e1e1",
		base08 = "#f8d8d8",
		base09 = "#cddafc",
		base0A = "#a19552",
		base0B = "#f1b9eb",
		base0C = "#ffacd0",
		base0D = "#5ac670",
		base0E = "#c3d2f6",
		base0F = "#c1b492",
	},
})

vim.api.nvim_set_hl(0, "Comment", { fg = color_text_dim })
vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { fg = color_text })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNrAbove", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNrBelow", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsUntracked", { bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignOk", { bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "none" })

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#303030" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#303030" })

local dashboard = require("alpha.themes.dashboard")
dashboard.file_icons_provider = "devicons"
require("alpha").setup(dashboard.opts)

local builtin = require("telescope.builtin")
require("telescope").setup({
	defaults = {
		file_ignore_patterns = { ".git/", ".vscode/" },
		mappings = { i = { ["<esc>"] = require("telescope.actions").close } },
	},
	pickers = {
		oldfiles = { cwd_only = true },
	},
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
	},
})

vim.keymap.set("n", "<leader>e", builtin.diagnostics, { desc = "List [E]rrors" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open [D]iagnostic" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Search [H]elp" })
vim.keymap.set("n", "<leader>f", function()
	builtin.find_files({ hidden = true })
end, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "[W]orkspace [S]earch(grep)" })
vim.keymap.set("n", "<leader>a", builtin.resume, { desc = "Search [A]gain" })
vim.keymap.set("n", "<leader>t", builtin.treesitter, { desc = "Search [T]reesitter" })
vim.keymap.set("n", "<leader>r", builtin.oldfiles, { desc = "Search [R]ecent Files" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>pl", function()
	builtin.planets({ show_pluto = true, show_moon = true })
end, { desc = "Search [PL]anets" })
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = true,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

require("which-key").setup({
	preset = "helix",
	icons = { mappings = vim.g.have_nerd_font },
})

require("gitsigns").setup({ current_line_blame = true })

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.ai").setup({ n_lines = 500 })

require("nvim-autopairs").setup({})

require("mini.indentscope").setup({
	draw = { delay = 50, animation = require("mini.indentscope").gen_animation.none() },
	symbol = "│",
})

require("mini.surround").setup()

local minifiles = require("mini.files")
minifiles.setup({
	mappings = { close = "<Esc>" },
	options = { permanent_delete = false, use_as_default_explorer = false },
	windows = { preview = true, width_nofocus = 20 },
})

local yazi = require("yazi")
yazi.setup({})
vim.keymap.set("n", "-", yazi.yazi)

local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })

require("scrollbar").setup({
	handle = { blend = 10, color = "#ff9999" },
})

require("conform").setup({
	notify_on_error = true,
	format_on_save = function(bufnr)
		local disable_filetypes = { c = true, cpp = true, sql = true }
		local lsp_format_opt = disable_filetypes[vim.bo[bufnr].filetype] and "never" or "fallback"
		return { timeout_ms = 1000, lsp_format = lsp_format_opt }
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		odin = { "odinfmt" },
		nix = { "alejandra" },
		json = { "biome" },
		jsonc = { "biome" },
		js = { "biome" },
		ts = { "biome" },
		jsx = { "biome" },
		tsx = { "biome" },
		html = { "biome" },
		css = { "biome" },
		graphql = { "biome" },
		rs = { "rustfmt" },
		proto = { "buf format" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		typ = { "typstyle" },
		kdl = { "kdlfmt" },
	},
	formatters = { sleek = { command = "sleek", args = { "$FILENAME" } } },
})

require("nvim-treesitter").setup({
	auto_install = true,
	highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
	indent = { enable = true, disable = { "ruby", "yaml" } },
})

require("todo-comments").setup({ signs = true })

require("fidget").setup({})

local twilight = require("twilight")
twilight.setup({})
vim.keymap.set("n", "<leader>ze", twilight.toggle, { desc = "Toggle [ZE]n mode" })

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		vim.api.nvim_buf_set_option(event.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
		map("K", vim.lsp.buf.hover, "[K]eyword documentation")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gd", function()
			builtin.lsp_definitions({ trim_text = true })
		end, "[G]oto [D]efinition")
		map("gr", builtin.lsp_references, "[G]oto [R]eferences")
		map("gi", builtin.lsp_implementations, "[G]oto [I]mplementation")
		map("gt", builtin.lsp_type_definitions, "Type [D]efinition")
		map("<F2>", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
		map("<C-k>", vim.lsp.buf.signature_help, "Signature [K]ick", "i")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

local default_lsp = { capabilities = capabilities }
local function setup_server(name, cfg)
	cfg = vim.tbl_deep_extend("force", default_lsp, cfg or {})
	vim.lsp.config[name] = cfg
	vim.lsp.enable(name)
end

local servers = {
	nixd = {},
	templ = {},
	lua_ls = {
		settings = {
			Lua = { completion = { callSnippet = "Replace" } },
			diagnostics = { globals = { "vim" } },
		},
	},
	gopls = {
		settings = {
			gopls = {
				analyses = { unusedparams = true },
				staticcheck = true,
				gofumpt = true,
				completeUnimported = true,
				usePlaceholders = true,
			},
		},
	},
	pyright = {},
	ols = {},
	rust_analyzer = {},
	sqls = {},
	clangd = {},
	yamlls = {
		settings = {
			yaml = {
				completion = true,
				schemas = { kubernetes = "*.yaml" },
				schemaStore = { enable = true },
				format = { enable = true },
				editor = { tabSize = 4 },
			},
		},
	},
	docker_compose_language_service = {},
	dockerls = {},
	buf_ls = {},
	tinymist = {},
	zls = {},
}

for name, cfg in pairs(servers) do
	setup_server(name, cfg)
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "docker-compose.yaml",
	command = "set filetype=yaml.docker-compose",
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			local kind_icons = {
				Text = "",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰇽",
				Variable = "󰂡",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰅲",
			}
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
			})[entry.source.name]
			return vim_item
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
	matching = { disallow_symbol_nonprefix_matching = false },
})

local dap = require("dap")

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/continue debug session" })
vim.keymap.set("n", "<F4>", dap.run_last, { desc = "Start debug session with last arguments" })
vim.keymap.set("n", "<F6>", dap.terminate, { desc = "Debug: terminate session" })
vim.keymap.set("n", "<M-h>", dap.step_out, { desc = "Debug: step out" })
vim.keymap.set("n", "<M-j>", dap.step_over, { desc = "Debug: step over" })
vim.keymap.set("n", "<M-k>", dap.step_back, { desc = "Debug: step back" })
vim.keymap.set("n", "<M-l>", dap.step_into, { desc = "Debug: step into" })
vim.keymap.set("n", "<M-b>", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#f92672" })
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" })

dap.listeners.after["event_initialized"]["me"] = function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
		for _, keymap in ipairs(keymaps) do
			if keymap.lhs == "K" then
				vim.api.nvim_buf_del_keymap(buf, "n", "K")
			end
		end
	end
	vim.api.nvim_set_keymap("n", "K", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after["event_terminated"]["me"] = function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
		for _, keymap in ipairs(keymaps) do
			if keymap.lhs == "K" then
				vim.api.nvim_buf_del_keymap(buf, "n", "K")
			end
		end
	end
	vim.keymap.set("n", "K", vim.lsp.buf.hover)
end

require("nvim-dap-virtual-text").setup()

-- require("nvim-dap-view").setup({ auto_toggle = true })

require("typst-preview").setup({
	dependencies_bin = { tinymist = nil, websocat = nil },
})
vim.keymap.set("n", "<leader>p", ":TypstPreviewToggle<CR>")

local grug = require("grug-far")
grug.setup()
vim.keymap.set("n", "<leader>R", grug.open)
