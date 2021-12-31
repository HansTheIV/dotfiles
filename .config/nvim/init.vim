set nocompatible
call plug#begin(stdpath('config') . '/plugged')

" Autocompletes
Plug 'sheerun/vim-polyglot'
Plug 'github/copilot.vim'
Plug 'ms-jpq/coq-nvim', { 'branch': 'coq' }
Plug 'ms-jpq/coq.artifacts', { 'branch': 'artifacts' }
Plug 'ms-jpq/coq.thirdparty', { 'branch': '3p' }

" Convenience
Plug 'liuchengxu/vista.vim'
" syntastic
Plug 'scrooloose/syntastic'

"Plug 'preservim/nerdtree'
Plug 'ms-jpq/chadtree', { 'branch': 'chad', 'do': 'python3 -m chadtree deps' }
Plug 'akinsho/nvim-bufferline.lua'
" Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/Colorizer'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'

call plug#end()


"
colorscheme gruvbox

" vanilla vim settings
set termguicolors
set nu rnu
set cursorline
set mouse=a
set ruler

" tab config
set noexpandtab
set tabstop=4
set copyindent
set preserveindent
" makes tab, trailing space characters visible
set listchars=tab:>\ ,trail:#,extends:>
set list
set shiftwidth=4
set softtabstop=0
set autoindent
set smartindent
set pastetoggle=<f5>
" set color of tab identifiers to be visible
autocmd VimEnter * hi groupA ctermbg=220 guibg=220
autocmd VimEnter * match groupA /\t/

syntax on

"plugin settings

"nerdtree mappings
nnoremap  <C-C> :CHADopen<CR>
"nnoremap  <C-f> :NERDTreeFind<CR>
" close vim if NERDTree is the last tab open
autocmd BufEnter * if tabpagenr('$') && winnr('$') == 1 && exists('b:CHADTree') && b:CHADTree.isTabTree() | quit | endif


"copilot
"remap complete to control + r
imap <silent><script><expr> <C-r> copilot#Accept("\<CR>")
"disable copilot's default tab-key completion
let g:copilot_no_tab_map = v:true

"Enable COQ autocomplete
autocmd VimEnter * COQnow

"Vista config
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
nnoremap <C-v> :Vista<CR>

"Syntastic settings

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_write = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatusLineFlag()}
set statusline+=%*

