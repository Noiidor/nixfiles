-- THIS CONFIG IS A MESS

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.g.loaded_netrwPlugin = 0

-- [[ Setting options ]]

vim.wo.wrap = false
vim.wo.linebreak = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true
vim.opt.smartindent = true
-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = false -- changed, default = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 15
vim.opt.jumpoptions = "stack,view"

-- Theme config
vim.cmd.colorscheme("base16-hardcore")

local dashboard = require("alpha.themes.dashboard")
dashboard.file_icons_provider = "devicons"
require("alpha").setup(dashboard.opts)

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<C-_>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<leader>lo", function()
	vim.opt.scrolloff = 999 - vim.o.scrolloff
end, { desc = "[LO]ck cursor in middle" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Telescope config
require("telescope").setup({
	-- You can put your default mappings / updates / etc. in here
	--  All the info you're looking for is in `:help telescope.setup()`
	--
	defaults = {
		--   mappings = {
		--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
		--   },
		file_ignore_patterns = { ".git/", ".vscode/" },
	},
	pickers = {
		oldfiles = {
			cwd_only = true,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
})

-- local border_color = vim.api.nvim_get_hl(vim.api.nvim_get_hl_id_by_name("CursorLine"), {})

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#303030" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#303030" })

-- Enable Telescope extensions if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")
pcall(require("telescope").load_extension, "file_browser")

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<leader>f", function()
-- 	require("telescope").extensions.file_browser.file_browser({
-- 		cwd = require("telescope.utils").buffer_dir(),
-- 		grouped = true,
-- 		hidden = true,
-- 		hijack_netrw = true,
-- 		auto_depth = true,
-- 	})
-- end, { desc = "[F]ile Browser" })

vim.keymap.set("n", "<leader>e", builtin.diagnostics, { desc = "List [E]rrors" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open [D]iagnostic" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Search [H]elp" })
-- vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })

vim.keymap.set("n", "<leader>f", function()
	builtin.find_files({
		hidden = true,
	})
end, { desc = "[F]ind [F]iles" })

vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
-- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "[W]orkspace [S]earch(grep)" })
vim.keymap.set("n", "<leader>a", builtin.resume, { desc = "Search [A]gain" })
vim.keymap.set("n", "<leader>t", builtin.treesitter, { desc = "Search [T]reesitter" })
vim.keymap.set("n", "<leader>r", builtin.oldfiles, { desc = "Search [R]ecent Files" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- NOTE: Secret :)
vim.keymap.set("n", "<leader>pl", function()
	builtin.planets({
		show_pluto = true,
		show_moon = true,
	})
end, { desc = "Search [PL]anets" })

vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = true,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Which-key config
require("which-key").setup({
	preset = "helix",
	icons = {
		-- set icon mappings to true if you have a Nerd Font
		mappings = vim.g.have_nerd_font,
		-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
		-- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
		keys = vim.g.have_nerd_font and {} or {
			Up = "<Up> ",
			Down = "<Down> ",
			Left = "<Left> ",
			Right = "<Right> ",
			C = "<C-…> ",
			M = "<M-…> ",
			D = "<D-…> ",
			S = "<S-…> ",
			CR = "<CR> ",
			Esc = "<Esc> ",
			ScrollWheelDown = "<ScrollWheelDown> ",
			ScrollWheelUp = "<ScrollWheelUp> ",
			NL = "<NL> ",
			BS = "<BS> ",
			Space = "<Space> ",
			Tab = "<Tab> ",
			F1 = "<F1>",
			F2 = "<F2>",
			F3 = "<F3>",
			F4 = "<F4>",
			F5 = "<F5>",
			F6 = "<F6>",
			F7 = "<F7>",
			F8 = "<F8>",
			F9 = "<F9>",
			F10 = "<F10>",
			F11 = "<F11>",
			F12 = "<F12>",
		},
	},

	-- Document existing key chains
	-- spec = {
	-- 	{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
	-- 	{ "<leader>d", group = "[D]ocument" },
	-- 	{ "<leader>r", group = "[R]ename" },
	-- 	{ "<leader>s", group = "[S]earch" },
	-- 	{ "<leader>w", group = "[W]orkspace" },
	-- 	{ "<leader>t", group = "[T]oggle" },
	-- 	{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
	-- },
})

-- Gitsigns config
require("gitsigns").setup({
	current_line_blame = true,
})

local devicons = require("nvim-web-devicons")

devicons.setup({
	override_by_extension = {
		["go"] = {
			icon = "",
			color = "#00add8",
			name = "Golang",
		},
	},
})

-- Mini config
require("mini.ai").setup({ n_lines = 500 })

local animate = require("mini.animate")
animate.setup({
	cursor = { enable = false },
	scroll = {
		timing = animate.gen_timing.linear({ duration = 3 }),
	},
})

-- require("mini.pairs").setup()
require("nvim-autopairs").setup({})

local minifiles = require("mini.files")
minifiles.setup({
	mappings = {
		close = "<Esc>",
	},
	options = {
		permanent_delete = false,
		use_as_default_explorer = false,
	},
	windows = {
		preview = true,
		width_nofocus = 20,
	},
})

vim.keymap.set("n", "-", minifiles.open, { desc = "Open file browser" })

local indentscope = require("mini.indentscope")
indentscope.setup({
	draw = {
		delay = 50,
		animation = indentscope.gen_animation.none(),
	},
	symbol = "│",
})

-- Add/delete/replace surroundings (brackets, quotes, etc.)
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup()

require("better_escape").setup()

local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })

-- Formatters config
require("conform").setup({
	notify_on_error = true,
	format_on_save = function(bufnr)
		-- Disable "format_on_save lsp_fallback" for languages that don't
		-- have a well standardized coding style. You can add additional
		-- languages here or re-enable it for the disabled ones.
		local disable_filetypes = {
			c = true,
			cpp = true,
			sql = true,
		}
		local lsp_format_opt
		if disable_filetypes[vim.bo[bufnr].filetype] then
			lsp_format_opt = "never"
		else
			lsp_format_opt = "fallback"
		end
		return {
			timeout_ms = 1000,
			lsp_format = lsp_format_opt,
		}
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		odin = { "odinfmt" },
		nix = { "alejandra" },
		-- sql = { "sql-formatter" },
		json = { "biome" },
		jsonc = { "biome" },
		js = { "biome" },
		ts = { "biome" },
		jsx = { "biome" },
		tsx = { "biome" },
		html = { "biome" },
		css = { "biome" },
		graphql = { "biome" },
		yaml = { "yamlfmt" },
		rs = { "rustfmt" },
		proto = { "buf format" },
		-- You can use 'stop_after_first' to run the first available formatter from the list
		-- javascript = { "prettierd", "prettier", stop_after_first = true },
	},
	formatters = {
		sleek = {
			command = "sleek",
			args = { "$FILENAME" },
		},
	},
})

require("nvim-treesitter.configs").setup({
	-- ensure_installed = {
	-- 	"all",
	-- },
	auto_install = false,
	highlight = {
		enable = true,
		--  If you are experiencing weird indenting issues, add the language to
		--  the list of additional_vim_regex_highlighting and disabled languages for indent.
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = { enable = true, disable = { "ruby" } },
})

require("todo-comments").setup({
	signs = true,
})

require("fidget").setup({})

local twilight = require("twilight")
twilight.setup({})

vim.keymap.set("n", "<leader>ze", twilight.toggle, { desc = "Toggle [ZE]n mode" })

-- LSP

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Jump to the definition of the word under your cursor.
		--  This is where a variable was first declared, or where a function is defined, etc.
		--  To jump back, press <C-t>.
		map("gd", function()
			require("telescope.builtin").lsp_definitions({
				trim_text = true,
			})
		end, "[G]oto [D]efinition")

		-- Find references for the word under your cursor.
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		map("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

		-- Fuzzy find all the symbols in your current workspace.
		--  Similar to document symbols, except searches over your entire project.
		-- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		-- Rename the variable under your cursor.
		--  Most Language Servers support renaming across files, etc.
		map("<F2>", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate.
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Highlight references on cursor hover
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

		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set("n", "rn", vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
end

local cmp = require("cmp")
local luasnip = require("luasnip")

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

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body)
			-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
			-- Source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				-- latex_symbols = "[LaTeX]",
			})[entry.source.name]
			return vim_item
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
		-- completion = {
		-- 	border = "rounded",
		-- },
		documentation = {
			border = "rounded",
		},
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

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
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})

-- ###########
-- ### LSP ###
-- ###########

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- local servers = {
-- -- clangd = {},
-- -- gopls = {},
-- -- pyright = {},
-- -- rust_analyzer = {},
-- -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
-- --
--
-- lua_ls = {
--   -- cmd = {...},
--   -- filetypes = { ...},
--   -- capabilities = {},
--   settings = {
--     Lua = {
--       completion = {
-- 	callSnippet = 'Replace',
--       },
--       -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
--       -- diagnostics = { disable = { 'missing-fields' } },
--     },
--   },
-- },
-- }

local lspconfig = require("lspconfig")
local lspconfigs = require("lspconfig.configs")

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = { "vim" },
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.gopls.setup({
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
			completeUnimported = true,
			usePlaceholders = true,
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.pyright.setup({})

-- lspconfigs.postgres_lsp = {
-- 	default_config = {
-- 		name = "postgres_lsp",
-- 		cmd = { "postgres_lsp" },
-- 		filetypes = { "sql" },
-- 		single_file_support = true,
-- 		root_dir = lspconfig.util.find_git_ancestor,
-- 	},
-- }
--
-- lspconfig.postgres_lsp.setup({})
--
lspconfig.ols.setup({})

lspconfig.rust_analyzer.setup({})

lspconfig.sqls.setup({})

lspconfig.nil_ls.setup({})

lspconfig.yamlls.setup({
	settings = {
		yaml = {
			completion = true,
			schemas = {
				kubernetes = "*.yaml",
			},
			schemaStore = { enable = true },
			format = {
				enable = true,
			},
			editor = {
				tabSize = 4,
			},
		},
	},
})

lspconfig.docker_compose_language_service.setup({})

local function set_filetype(pattern, filetype)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = pattern,
		command = "set filetype=" .. filetype,
	})
end

set_filetype({ "docker-compose.yaml" }, "yaml.docker-compose")

lspconfig.dockerls.setup({})

lspconfig.buf_ls.setup({})

require("nvim-treesitter.configs").setup({
	indent = {
		enable = true,
		disable = { "yaml" },
	},
})

-- #############
-- ### Debug ###
-- #############

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
vim.fn.sign_define("DapBreakpoint", {
	text = "",
	texthl = "DapBreakpoint",
	linehl = "",
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "DapBreakpoint",
	linehl = "",
	numhl = "DapBreakpoint",
})

dap.listeners.after["event_initialized"]["me"] = function()
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
		for _, keymap in pairs(keymaps) do
			if keymap.lhs == "K" then
				vim.api.nvim_buf_del_keymap(buf, "n", "K")
			end
		end
	end
	vim.api.nvim_set_keymap("n", "K", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after["event_terminated"]["me"] = function()
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
		for _, keymap in pairs(keymaps) do
			if keymap.lhs == "K" then
				vim.api.nvim_buf_del_keymap(buf, "n", "K")
			end
		end
	end
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
end

-- DAP extensions
-- require("nvim-dap-virtual-text").setup()
require("dap-go").setup()
require("dap-python").setup("python")

local dapui = require("dapui")
dapui.setup({
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = "",
		},
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	force_buffers = true,
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = "",
	},
	layouts = {
		{
			elements = { {
				id = "scopes",
				size = 1,
			} },
			position = "left",
			size = 45,
		},
		{
			elements = {
				{
					id = "repl",
					size = 1,
				},
			},
			position = "bottom",
			size = 20,
		},
	},
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t",
	},
	render = {
		indent = 1,
		max_value_lines = 100,
	},
})
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
