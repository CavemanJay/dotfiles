call plug#begin()

Plug 'skywind3000/asyncrun.vim'

Plug 'TimUntersberger/neogit'

Plug 'caenrique/nvim-toggle-terminal'

Plug 'williamboman/nvim-lsp-installer'

Plug 'mhinz/vim-startify'

Plug 'beauwilliams/focus.nvim'

Plug 'nvim-lualine/lualine.nvim'

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
let g:asyncrun_open = 8
colorscheme material

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
" set completeopt=menuone,noinsert,noselect
set completeopt=menuone,noinsert

" Avoid showing extra messages when using completion
set shortmess+=c

lua <<EOF
require('nvim_comment').setup()
require('nvim-tree').setup()
require('lualine').setup()
require('focus').setup()
require("nvim-lsp-installer").setup {}

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
" Use system clipboard for yanking/pasting
set clipboard=unnamed 
set colorcolumn=80

command EditConfig :edit ~/.config/nvim/init.vim
command EditConfigWin32 :edit ~/AppData/Local/nvim/init.vim
command Reloc :cd %:p:h
command BufCurOnly execute '%bdelete|edit#|bdelete#'


set updatetime=300
" autocmd CursorHold * Lspsaga hover_doc
autocmd TermOpen * startinsert

" CODE NAVIGATION
" code hover
" nnoremap <silent> <Leader>ch   <cmd>Lspsaga hover_doc<CR>
nnoremap <silent> gch   <cmd>Lspsaga hover_doc<CR>
" code (quick) actions
" nnoremap <silent> <Leader>ca   <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gca   <cmd>lua vim.lsp.buf.code_action()<CR>
" code comment
" nnoremap <silent> <Leader>cc   <cmd>CommentToggle<CR>
" code grep
" nnoremap <silent> <Leader>cg   <cmd>Telescope live_grep<CR>
nnoremap <silent> gcg   <cmd>Telescope live_grep<CR>

" SCHEMA => c: Code -> s: Symbol -> action
" code symbol implementation
" nnoremap <silent> <Leader>csi  <cmd>Telescope lsp_implementations<CR>
" " code symbol/signature help
" nnoremap <silent> <Leader>csh  <cmd>lua vim.lsp.buf.signature_help()<CR>
" " code symbol definition
" nnoremap <silent> <Leader>csd  <cmd>Telescope lsp_definitions<CR>
" nnoremap <silent> <Leader>csD  <cmd>Telescope lsp_type_definitions<CR>
" " code symbol references
" nnoremap <silent> <Leader>csr  <cmd>Telescope lsp_references<CR>
" " code symbol Rename
" nnoremap <silent> <Leader>csR  <cmd>Lspsaga rename<CR>
" " code symbols list document
" nnoremap <silent> <Leader>csld <cmd>Telescope lsp_document_symbols<CR>
" " code symbols list workspace
" nnoremap <silent> <Leader>cslw <cmd>Telescope lsp_workspace_symbols<CR>


nnoremap <silent> gci  <cmd>Telescope lsp_implementations<CR>
" code symbol/signature help
nnoremap <silent> gcH  <cmd>lua vim.lsp.buf.signature_help()<CR>
" code symbol definition
nnoremap <silent> gcd  <cmd>Telescope lsp_definitions<CR>
nnoremap <silent> gcD  <cmd>Telescope lsp_type_definitions<CR>
" code symbol references
nnoremap <silent> gcr  <cmd>Telescope lsp_references<CR>
" code symbol Rename
nnoremap <silent> gcR  <cmd>Lspsaga rename<CR>
" code symbols list document
nnoremap <silent> gcls <cmd>Telescope lsp_document_symbols<CR>
" code symbols list workspace
nnoremap <silent> gclS <cmd>Telescope lsp_workspace_symbols<CR>

" SCHEMA => c: Code -> d: Diagnostics => action
" code diagnostics next
nnoremap <silent> gcen <cmd>Lspsaga diagnostic_jump_next<CR>
" code diagnostics previous
nnoremap <silent> gcep <cmd>Lspsaga diagnostic_jump_prev<CR>
" code diagnostics error
nnoremap <silent> gcee <cmd>lua require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>

" SCHEMA => v: Vim -> action
" vim change dir (to current file)
nnoremap <silent> <Leader>vcd <cmd>Reloc<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil,800)

let mapleader = "\<Space>"
nnoremap <c-p> <cmd>Telescope find_files<CR>
nnoremap <Leader>ff <cmd>Telescope find_files<CR>
nnoremap <Leader>fg <cmd>Telescope live_grep<CR>
nnoremap <Leader>fb <cmd>Telescope buffers<CR>
nnoremap <Leader>fh <cmd>Telescope help_tags<CR>
nnoremap <Leader>fc <cmd>Telescope commands<CR>
nnoremap <Leader>fm <cmd>Telescope marks<CR>

" Windows
nnoremap <Leader>wc <cmd>close<CR>
nnoremap <Leader>ws <cmd>FocusSplitNicely<CR>
nnoremap <Leader>wh <cmd>FocusSplitLeft<CR>
nnoremap <Leader>wj <cmd>FocusSplitDown<CR>
nnoremap <Leader>wk <cmd>FocusSplitUp<CR>
nnoremap <Leader>wl <cmd>FocusSplitRight<CR>
nnoremap <Leader>w= <cmd>FocusEqualise<CR>
nnoremap <Leader>wo <cmd>on<CR>
nnoremap <Leader>wt <cmd>bo term<CR> " Open terminal on bottom
nnoremap <c-x> <cmd>ToggleTerminal<CR>

" File tree
nnoremap <Leader>no <cmd>NvimTreeOpen<CR>
nnoremap <Leader>nc <cmd>NvimTreeClose<CR>
nnoremap <Leader>nt <cmd>NvimTreeToggle<CR>

" Buffers
nnoremap <Leader>bp <cmd>bprev<CR>
nnoremap <Leader>bn <cmd>bnext<CR>
nnoremap <Leader>bb <cmd>Telescope buffers<CR>
nnoremap <Leader>bc <cmd>BufCurOnly<CR>
