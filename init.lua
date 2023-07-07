-- Vim settings --

require("plugins")

-- General editor settings --
vim.opt.mouse = "a"           -- enable mouse support (might not work well on Mac OS X)
vim.opt.encoding = "utf-8"    -- set encoding to utf-8
vim.opt.number = true         -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.wildmenu = true       -- visual autocomplete for command menu
vim.opt.lazyredraw = true     -- redraw screen only when we need to
vim.opt.showmatch = true      -- highlight matching parentheses / brackets [{()}]
vim.opt.visualbell = false    -- disable visual bell
--vim.opt.signcolumn = "no" -- show line number on statusline
vim.opt.signcolumn = "yes"    -- show sings on the left of the number, as much as possible symbols
vim.opt.wrap = false          -- avoid wrapping lines
vim.opt.swapfile = false      -- disable swapfile
vim.opt.ttyfast = true        -- Avoid Ctrl-S freezing the terminal
-- persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
-- Leader keys
vim.g.mapleader = " "   -- set leader key to space
vim.g.localleader = "," -- set localleader to comma

-- Key mappings --
vim.keymap.set("n", "j", "gj")      -- move by visual line (useful for wrapped lines)
vim.keymap.set("n", "k", "gk")      -- move by visual line
vim.keymap.set("n", "<down>", "gj") -- move by visual line
vim.keymap.set("n", "<up>", "gk")   -- move by visual line
-- Select all file and copy to clipboard
vim.keymap.set("n", "gA", "m'ggVG\"+y''")
-- Move selected lines up and down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
-- Save
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:w<CR>")
-- Unset last search pattern
vim.keymap.set("n", "<CR>", ":noh<CR><CR>")
-- Jump between buffers
vim.keymap.set("n", "<leader><leader>", "<C-^>")
-- Close current buffer
vim.keymap.set("n", "<leader>q", "<Esc>:bd<CR>")
vim.keymap.set("n", "<A-q>", "<Esc>:bd<CR>")
-- Next buffer
vim.keymap.set("n", "<A-j>", "<Esc>:bn<CR>")
-- Previous buffer
vim.keymap.set("n", "<A-k>", "<Esc>:bp<CR>")
-- New buffer
vim.keymap.set("n", "<A-n>", ":enew<CR>")
-- Toggle wrap
vim.keymap.set("n", "<A-z>", "<Esc>:set wrap!<CR>")
-- Join lines without space between
vim.keymap.set("n", "J", "gJ")
-- Reload luafile
vim.keymap.set("n", "<leader>r", "<Esc>:luafile %<CR>")
-- Load git diff
vim.keymap.set("n", "<leader>gd", "<Esc>:Gitsigns toggle_word_diff<CR>")
-- Tabs and indents
vim.opt.tabstop = 4               -- number of spaces that a <TAB> counts for
vim.opt.shiftwidth = 4            -- number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4           -- backspace after pressing <TAB> will remove up to this many spaces
vim.opt.expandtab = true          -- convert <TAB> key-presses to spaces
-- Indentation settings
vim.opt.autoindent = true         -- copy indent from current line when starting a new line
vim.opt.smartindent = true        -- even better autoindent (e.g. add indent after '{')
vim.opt.smarttab = true           -- useful when softtabstop and shiftwidth are different
-- Search settings
vim.opt.ignorecase = true         -- ignore case when searching
vim.opt.smartcase = true          -- start case-insensitive, as soon as a capital letter appears, switch to case-sensitive
vim.opt.incsearch = true          -- search as characters are entered
vim.opt.hlsearch = true           -- highlight matches
-- Misc settings
vim.opt.cursorline = true         -- highlight current line
vim.opt.background = "dark"       -- configure Vim to use darker colors
vim.opt.autoread = true           -- autoreload the file in Vim if it has been changed outside of Vim
vim.opt.clipboard = "unnamedplus" -- link global clipboard

-- Colorscheme --
vim.cmd.colorscheme "catppuccin"
require('lualine').setup {
    options = {
        theme = 'auto',
        section_separators = '',
        component_separators = '|'
    },
}

vim.opt.termguicolors = true
require("bufferline").setup()

-- Plugin configs and mapppings --

-- NERDTree and Undotree
vim.keymap.set("n", "<F6>", ":NERDTreeToggle<CR>")  -- toggle NERDTree
vim.keymap.set("n", "<F10>", ":UndotreeToggle<CR>") -- toggle Undotree
vim.cmd [[ let NERDTreeShowHidden = 1 ]]

-- Telescope
require('telescope').setup {
    pickers = {
        find_files = {
            hidden = true
        }
    }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-t>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set("n", "<leader>e", builtin.diagnostics, {})
-- FTerm
require 'FTerm'.setup({
    cmd = 'pwsh -nologo',
    border = 'double',
})
vim.keymap.set('n', '<F12>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<F12>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
-- LSP zero
local lsp = require('lsp-zero')
local cmp = require('cmp')

lsp.preset('recommended')
--lsp.setup_nvim_cmp({
--mapping = cmp.mapping.preset.insert({
--['<Tab>'] = vim.NIL,
--['<S-Tab>'] = vim.NIL,
--['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--["<C-Space>"] = cmp.mapping(cmp.mapping.complete({
--reason = cmp.ContextReason.Auto,
--}), { "i", "c" }),
--})
--})

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
    }
})


-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    cmd = { 'lua-language-server' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
})
lsp.setup()

-- Gitsigns
require('gitsigns').setup()
-- Mason 'marketplace' for lsp servers
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Marks
require('marks').setup {
    -- whether to map keybinds or not. default true
    default_mappings = true,
    -- which builtin marks to show. default {}
    builtin_marks = { ".", "<", ">", "^" },
    -- whether movements cycle back to the beginning/end of buffer. default true
    cyclic = true,
    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = false,
    -- how often (in ms) to redraw signs/recompute mark positions.
    -- higher values will have better performance but may cause visual lag,
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 250,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    -- disables mark tracking for specific filetypes. default {}
    excluded_filetypes = {},
    -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
    -- sign/virttext. Bookmarks can be used to group together positions and quickly move
    -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
    -- default virt_text is "".
    bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
        -- defaults to false.
        annotate = false,
    },
    mappings = {}
}

-- Treesiter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python", "typescript", "tsx", "cpp" },
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = true, -- highlight also in vim's regexes:
    },
    indent = {
        enable = true,
        disable = {},
    },
}

-- Rust-tools
local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
})
