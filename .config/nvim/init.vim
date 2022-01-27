set nocompatible
call plug#begin(stdpath('config') . '/plugged')

" Autocompletes
Plug 'sheerun/vim-polyglot'
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Convenience
Plug 'liuchengxu/vista.vim'
" Syntax Checker
Plug 'scrooloose/syntastic'
" Navigation plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'akinsho/nvim-bufferline.lua'
" Appearance
Plug 'chrisbra/Colorizer'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'

"NoteTaking
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make' }
Plug 'aarleks/zettel.vim'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'

call plug#end()

let g:zettelkasten = '/home/eringel/notes/'

" vanilla vim settings
set termguicolors
set nu rnu
set cursorline
set mouse=a
set ruler
let mapleader=","

" tab config
set noexpandtab
set tabstop=4
set copyindent
set preserveindent
set hidden
set nobackup
set nowritebackup

" makes tab, trailing space characters visible
set listchars=tab:>\ ,trail:#,extends:>
set list
set shiftwidth=4
set softtabstop=0
set autoindent
set smartindent
set pastetoggle=<f5>

colorscheme gruvbox

"coc configs
set updatetime=300
set shortmess+=c
set signcolumn=number

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "<\TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
function! s:check_back_space() abort
	let col = col('.') -1
	return !col || getline('.')[col-1] =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-prev)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if(index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif(coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '|' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)


xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" set color of tab identifiers to be visible
autocmd VimEnter * hi groupA ctermbg=220 guibg=220
autocmd VimEnter * match groupA /\t/
syntax on

"plugin settings

"nerdtree mappings
nnoremap  <C-C> :NERDTree<CR>
nnoremap  <C-f> :NERDTreeFind<CR>
" close vim if NERDTree is the last tab open
autocmd BufEnter * if tabpagenr('$') && winnr('$') == 1 && exists('b:CHADTree') && b:CHADTree.isTabTree() | quit | endif


"copilot
"remap complete to control + r
imap <silent><script><expr> <C-r> copilot#Accept("\<CR>")
"disable copilot's default tab-key completion
let g:copilot_no_tab_map = v:true

let g:vimtex_complete_enabled = 0

"Vista config
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
nnoremap <C-v> :Vista<CR>

let g:vista_default_executive = 'coc'
let g:vista_stay_on_open = 0


"vimtex 
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0

let g:tex_conceal = ''
set conceallevel=0


"Syntastic settings

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_write = 1

let g:coc_global_extensions = ['coc-git', 'coc-java', 'coc-pairs', 'coc-pyright',
		\ 'coc-sh', 'coc-html', 'coc-json', 'coc-vimtex']


