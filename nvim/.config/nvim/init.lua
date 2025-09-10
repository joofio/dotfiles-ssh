-- Neovim Configuration
-- Modern Lua-based configuration with essential settings

-- Basic settings
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true   -- Show relative line numbers
vim.opt.mouse = 'a'             -- Enable mouse support
vim.opt.ignorecase = true       -- Ignore case in search
vim.opt.smartcase = true        -- Smart case matching
vim.opt.hlsearch = false        -- Don't highlight search results
vim.opt.wrap = false            -- Don't wrap lines
vim.opt.breakindent = true      -- Maintain indentation when wrapping
vim.opt.tabstop = 4             -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4          -- Number of spaces to use for each step of autoindent
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.smartindent = true      -- Smart autoindenting
vim.opt.splitbelow = true       -- Horizontal splits go below
vim.opt.splitright = true       -- Vertical splits go right
vim.opt.termguicolors = true    -- Enable 24-bit colors
vim.opt.updatetime = 250        -- Decrease update time
vim.opt.timeoutlen = 300        -- Time to wait for mapped sequence
vim.opt.backup = false          -- Don't create backup files
vim.opt.writebackup = false     -- Don't create backup before overwriting
vim.opt.swapfile = false        -- Don't create swap files
vim.opt.undofile = true         -- Enable persistent undo
vim.opt.signcolumn = 'yes'      -- Always show sign column
vim.opt.cursorline = true       -- Highlight current line

-- Key mappings
vim.g.mapleader = ' '           -- Set leader key to space
vim.g.maplocalleader = ' '

-- Essential keymaps
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Move lines up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keep cursor centered when jumping
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Resize windows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Clear search highlighting
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- File operations
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>x', ':x<CR>')

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
augroup('highlight_yank', { clear = true })
autocmd('TextYankPost', {
  group = 'highlight_yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
})

-- Auto-format on save for certain file types
augroup('auto_format', { clear = true })
autocmd('BufWritePre', {
  group = 'auto_format',
  pattern = { '*.lua', '*.py', '*.js', '*.ts', '*.json', '*.yaml', '*.yml' },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Set colorscheme (fallback to default if not available)
pcall(function()
  vim.cmd.colorscheme 'habamax'
end)

-- Status line
vim.opt.laststatus = 2
vim.opt.statusline = '%f %h%m%r%=%-14.(%l,%c%V%) %P'

-- Basic file type settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "json", "html", "css" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})