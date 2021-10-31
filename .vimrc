syntax on

set noerrorbells
set ts=4 sw=4 sts=4 et
set expandtab
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set guicursor=
set relativenumber
set hidden
set updatetime=300
set shortmess+=c
set colorcolumn=88
set encoding=UTF-8
set cmdheight=1
set mouse=a
set signcolumn=number
highlight ColorColumn ctermbg=0 guibg=black



call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'igankevich/mesonic'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'ayu-theme/ayu-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'vim-utils/vim-man'
Plug 'brooth/far.vim'
Plug 'puremourning/vimspector'
Plug 'mbbill/undotree'

Plug 'lyuts/vim-rtags'
call plug#end()



" Coloscheme & Theme
let ayucolor="dark"
let g:airline_theme='ayu_dark'
colorscheme ayu

" Global
let mapleader = " "

" NERDTree
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 30
let NERDTreeIgnore = [
    \ '\.pyc$',
    \ '\.lock$',
    \ '\.sqlite$',
    \ '\.qdrep$',
    \ '\.egg-info$',
    \ '__pycache__'
    \ ]

" VimInspector
let g:vimspector_enable_mappings = 'HUMAN'

" Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gn",
    },
  },
}
EOF

" Coc
let g:ale_disable_lsp = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_cpp_cpplint_options = '--linelength=88'

let g:ale_linters = {
    \ 'cpp': ["clangd"],
    \ }

let g:coc_user_config = {
    \ 'diagnostic.displayByAle': v:true,
    \ 'clangd.semanticHighlighting': v:true,
    \ 'python.linting.flake8Enabled': v:true,
    \ }

let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-prettier',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-clangd',
    \ 'coc-yaml',
    \ 'coc-julia',
    \ 'coc-html',
    \ 'coc-cmake',
    \ 'coc-marketplace',
    \ 'coc-webpack',
    \ 'coc-pyright',
    \ 'coc-markdownlint',
    \ 'coc-xml',
    \ ]



" Miscellaneous Shortcuts
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set backspace=indent,eol,start

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 50)
augroup END

autocmd BufWritePre * :call TrimWhitespace()

vnoremap X "_d
inoremap <C-c> <esc>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

command! -nargs=0 Prettier :CocCommand prettier.formatFile
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Create alias for uppercase after :
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W","w")
call SetupCommandAlias("Q","q")
call SetupCommandAlias("Wq","wq")



" NERDTree
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>pv :NERDTree<CR>
nnoremap <leader>pc :NERDTreeClose<CR>
nnoremap <leader>pe :CocCommand python.setInterpreter<CR>


" Git Fugitive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :Git<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gp :Git push<CR>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files <cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Coc
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
