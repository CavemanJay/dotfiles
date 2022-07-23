call plug#begin()

Plug 's1n7ax/nvim-terminal'

Plug 'williamboman/nvim-lsp-installer'

Plug 'mhinz/vim-startify'

Plug 'beauwilliams/focus.nvim'

Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Fuzzy finder
" Optional
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Color scheme used in the GIFs!
"Plug 'arcticicestudio/nord-vim'

" Commenting plugin
Plug 'terrortylor/nvim-comment'

" UI stuff
Plug 'RishabhRD/popfix'
Plug 'hood/popui.nvim'
Plug 'glepnir/lspsaga.nvim'

Plug 'famiu/nvim-reload'

Plug 'marko-cerovac/material.nvim'

call plug#end()

" set theme
let g:material_style = "darker"
colorscheme material

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

lua <<EOF
require('nvim_comment').setup()
require('nvim-tree').setup()
require('lualine').setup()
require('focus').setup()
require("nvim-lsp-installer").setup {}
require("nvim-terminal").setup {}

vim.opt.list = true
vim.opt.listchars:append("eol:↴")
require('indent_blankline').setup{
	show_end_of_line=true,
	show_current_context=true,
	show_current_context_start=true,
}

vim.ui.select = require"popui.ui-overrider"
vim.ui.input = require"popui.input-overrider"
EOF

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
     server = {
         -- on_attach is a callback called when the language server attachs to the buffer
         -- on_attach = on_attach,
         settings = {
             -- to enablesumneko_luarust-analyzer settings visit:
             -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
             ["rust-analyzer"] = {
                 -- enable clippy on save
                 checkOnSave = {
                     command = "clippy"
                 },
             },
         }
     },
}

require('rust-tools').setup(opts)
require'lspconfig'.pyright.setup{}
require'lspconfig'.sumneko_lua.setup{}
require'lspconfig'.omnisharp.setup{}
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF


lua <<EOF
local saga = require 'lspsaga'
saga.init_lsp_saga()
EOF

set mouse+=a
set relativenumber
set colorcolumn=80

" Code navigation
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> K     <cmd>Lspsaga hover_doc<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> gr    <cmd>Lspsaga lsp_finder<CR>
nnoremap <silent> gR    <cmd>Lspsaga rename<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>


" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
"autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
"autocmd CursorHold * Lspsaga show_line_diagnostics

" Goto previous/next diagnostic warning/error
" nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
" nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> g[ <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> g] <cmd>Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> ge <cmd>lua require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()

command EditConfig :edit ~/.config/nvim/init.vim
command EditConfigWin32 :edit ~/AppData/Local/nvim/init.vim

let mapleader = "\<Space>"
nnoremap <c-p> <cmd>Telescope find_files<CR>
nnoremap <Leader>fg <cmd>Telescope live_grep<CR>
nnoremap <Leader>fb <cmd>Telescope buffers<CR>
nnoremap <Leader>fh <cmd>Telescope help_tags<CR>
nnoremap <Leader>fc <cmd>Telescope commands<CR>
nnoremap <Leader>fr <cmd>Telescope lsp_references<CR>
nnoremap <Leader>fd <cmd>Telescope lsp_definitions<CR>
nnoremap <Leader>fi <cmd>Telescope lsp_implementations<CR>

" Windows
nnoremap <Leader>wc <cmd>close<CR>
nnoremap <Leader>ws <cmd>FocusSplitNicely<CR>
nnoremap <Leader>wh <cmd>FocusSplitLeft<CR>
nnoremap <Leader>wj <cmd>FocusSplitDown<CR>
nnoremap <Leader>wk <cmd>FocusSplitUp<CR>
nnoremap <Leader>wl <cmd>FocusSplitRight<CR>
nnoremap <Leader>wt <cmd>FocusSplitDown cmd term<CR>
nnoremap <Leader>w= <cmd>FocusEqualise<CR>
nnoremap <Leader>wo <cmd>on<CR>

" File tree
nnoremap <Leader>no <cmd>NvimTreeOpen<CR>
nnoremap <Leader>nc <cmd>NvimTreeClose<CR>
nnoremap <Leader>nt <cmd>NvimTreeToggle<CR>

" Buffers
nnoremap <Leader>bn <cmd>bnext<CR>
nnoremap <Leader>bp <cmd>bprev<CR>
