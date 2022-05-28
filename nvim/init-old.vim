"-------------------------------------------------------------------------------
" Set
"-------------------------------------------------------------------------------

" preferences for :find
set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu

" init autocmd
autocmd!

if has('nvim')
  set inccommand=split
endif

set number
set relativenumber
set clipboard=unnamed
set nocompatible
syntax enable
set background=dark
set encoding=utf-8
set title
set autoindent
set autoread
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set signcolumn=yes
set scrolloff=10
set expandtab
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=
" Don't redraw while executing macros (good performance config)
set lazyredraw
set re=1
" Ignore case when searching
set ignorecase
" Be smart when using tabs
set smarttab
"" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent

" Try to improve performance
set synmaxcol=128
syntax sync minlines=256
set nocursorcolumn
set nocursorline
" set norelativenumber

" This – along autoread is aiming at realoading a file
" after it was changed outside of vim.
au FocusGained,BufEnter * :checktime

"-------------------------------------------------------------------------------
" Highlights
"-------------------------------------------------------------------------------

set cursorline
"set cursorcolumn

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40
highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

"-------------------------------------------------------------------------------
" Emmet
"-------------------------------------------------------------------------------

" Remapping <C-y>, just doesn't cut it.
function! s:expand_html_tab()
  " try to determine if we're within quotes or tags.
  " if so, assume we're in an emmet fill area.
   let line = getline('.')
   if col('.') < len(line)
     let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')
     if len(line) >= 2
        return "\<C-n>"
     endif
   endif
  " expand anything emmet thinks is expandable.
  if emmet#isExpandable()
    return emmet#expandAbbrIntelligent("\<tab>")
    " return "\<C-y>,"
  endif
  " return a regular tab character
  return "\<tab>"
endfunction
 " let g:user_emmet_expandabbr_key='<Tab>'
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

autocmd FileType html,css,scss,liquid,typescriptreact,vue,javascript,markdown.mdx imap <silent><buffer><expr><tab> <sid>expand_html_tab()
let g:user_emmet_mode='a'
let g:user_emmet_complete_tag = 0
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss,liquid,liquid,typescriptreact,vue,javascript,markdown.mdx EmmetInstall

"------------------------------------------------------------------------------
" File types
"-------------------------------------------------------------------------------

" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript

set suffixesadd=.js,.es,.jsx,.json,.css,.scss,.less,.sass,.styl,.php,.py,.md

"-------------------------------------------------------------------------------
" Key maping
"-------------------------------------------------------------------------------

let mapleader = " "
map <leader><CR> :so ~/.config/nvim/init.vim<CR>

" Use Command + S (<D-s>) to save. Requires <D-s> to
" fire <C-z> inside the terminal as an intermediate command.
" https://stackoverflow.com/a/63458243
noremap  <silent> <C-z> :w<CR>
inoremap  <silent> <C-z> <ESC>:w<CR>i

map <leader>f <PageDown>
map <leader>b <PageUp>
map <leader>d <C-d>
map <leader>u <C-u>

" Select all
nmap <leader>a gg<S-v>G

" Let's try this again
inoremap jk <Esc>
inoremap kj <Esc>

" Navigate between tabs
" nmap <S-Tab> :tabprev<Return>
" nmap <Tab> :tabnext<Return>

" Why is it backward
nnoremap <Tab> >>
nnoremap <S-Tab> <<

" Also this is cool… I think?
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Split window
nmap ss :split<Return><C-w>w
nmap vs :vsplit<Return><C-w>w

" Navigate between windows
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

" Who needs H, M and L
nnoremap H ^
nnoremap L $

" Open new tabs
nmap te :tabedit<Return>

" since <Tab> === <C-i> we need to find a new solution
" for the jump list. And also, put them in the right order
" while we're at it.
nnoremap <leader>o <C-i>
nnoremap <leader>i <C-o>

" Navigate in quickfix lists
nnoremap <C-h> :cprev<CR>zz
nnoremap <C-l> :cnext<CR>zz

" Move group of lines in all modes
vnoremap J :move '>+1<CR>gv=gv
vnoremap K :move '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==

" fugitive
nmap <leader>gs :G<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

" Keep focus in the center
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Allow for smaller chunks of undos (can add more breakpoints)
inoremap . .<c-g>u
inoremap , ,<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Replace multiple occurences of a word.
" Enter cn (or cN) anywhere on top of a word. Enter new word,
" escape and use . as many times as needed.
nnoremap cn *``cgn
nnoremap cN *``cgN

" Highlights when yanking
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=100})
augroup END

""-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

if has("nvim")
  " Git
  Plug 'ThePrimeagen/git-worktree.nvim'
  " Plug 'f-person/git-blame.nvim'

  " Editing
  Plug 'hoob3rt/lualine.nvim'
  Plug 'psliwka/vim-smoothie'
  Plug 'numToStr/Comment.nvim'
  Plug 'mattn/emmet-vim'
  Plug 'windwp/nvim-autopairs'
  Plug 'ThePrimeagen/harpoon'
  Plug 'lukas-reineke/indent-blankline.nvim'

  " Lsp / treesitter
  Plug 'neovim/nvim-lspconfig'
  Plug 'tami5/lspsaga.nvim'
  Plug 'folke/lsp-colors.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Autocompletion
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'

  " Snippets
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'rafamadriz/friendly-snippets'

  " Filer
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

  " Telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
endif

lua << EOF
  vim.g.snippets = "luasnip"
EOF

Plug 'groenewege/vim-less', { 'for': 'less' }

call plug#end()

lua require('git-worktree').setup()
lua require('Comment').setup()
lua require('nvim-autopairs').setup()

""-------------------------------------------------------------------------------
" Color scheme
"-------------------------------------------------------------------------------

" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0 " sets transparency for floating windows
  set wildoptions=pum
  set pumblend=5 " sets pseudo-transparency for popup-menu
  set background=dark
  " let g:neosolarized_contrast = "high"
  " let g:neosolarized_vertSplitBgTrans = 1
  let g:neosolarized_termtrans=1
  runtime ./colors/NeoSolarized.vim
  colorscheme NeoSolarized
endif

"-------------------------------------------------------------------------------
" Misc
"-------------------------------------------------------------------------------

set exrc

function! <SID>TrimWhitespace()
  if !&binary && &filetype != 'diff'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfun

augroup GROUP_FUNCTIONMARIUS
  autocmd!
  autocmd BufWritePre * :call <SID>TrimWhitespace()
augroup END