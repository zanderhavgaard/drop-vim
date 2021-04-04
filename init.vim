
"      _                            _
"   __| |_ __ ___  _ __      __   _(_)_ __ ___
"  / _` | '__/ _ \| '_ \ ____\ \ / / | '_ ` _ \
" | (_| | | | (_) | |_) |_____\ V /| | | | | | |
"  \__,_|_|  \___/| .__/       \_/ |_|_| |_| |_|
"                 |_|
"
" by @zanderhavgaard ~ github.com/zanderhavgaard/drop-vim

" ===== Providers ======

" first we disable some integrations we do not need
" to speed up start time
" disable ruby integration
let g:loaded_ruby_provider = 0
" disable node.js integration
let g:loaded_node_provider = 0
" disable python2 integration
let g:loaded_python_provider = 0
" disable python3 integration
let g:python3_host_prog = 0
" disable perl provider
let g:loaded_perl_provider = 0

" ===== Vim Plug =====

" install plugins
call plug#begin('~/.vim/plugged')

" ===== plugins =====

" register vim-plug to get help files
Plug 'junegunn/vim-plug'

" sensible defaults for many vim settings
Plug 'tpope/vim-sensible'

" visual file browser
Plug 'preservim/nerdtree'
" git integration for nerd tree
Plug 'Xuyuanp/nerdtree-git-plugin'

" TODO keep?
" add icons to stuff
Plug 'ryanoasis/vim-devicons'

" starting splash screen with sessions
Plug 'mhinz/vim-startify'

" autocloses brackets and parentheses in insert mode
Plug 'Raimondi/delimitMate'

" autoclose html/xml style tags
Plug 'alvan/vim-closetag'

" synyax support for many languages
" disable polyglot syntax highlighting for shell languages,
" must be set before loading the plugin
let g:polyglot_disabled = ['bash','sh','zsh']
Plug 'sheerun/vim-polyglot'

" clpse all buffers not open in a window
Plug 'artnez/vim-wipeout'

" git gutter
Plug 'airblade/vim-gitgutter'

" git controls
Plug 'tpope/vim-fugitive'

" inline git blame
Plug 'APZelos/blamer.nvim'

" draws indent guides based on spaces
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'

" automatically set indent width
Plug 'tpope/vim-sleuth'

" highlight unique characters in lines to allow quick horizontal movement
Plug 'unblevable/quick-scope'

" adds file handling to vim command mode
Plug 'tpope/vim-eunuch'

" toggle lines as comment
Plug 'scrooloose/nerdcommenter'

" sensibly toggle between absolute and relative line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" nicer status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" show colorcodes as background
Plug 'chrisbra/Colorizer'

" color matching parentheses in scope
Plug 'luochen1990/rainbow'

" help finding Keybindings
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'liuchengxu/vim-which-key'

" docker files syntax
Plug 'ekalinin/Dockerfile.vim'

" easily swap window positions
Plug 'wesQ3/vim-windowswap'

" cheatsheet for vim
Plug 'lifepillar/vim-cheat40'

" ===== colorschemes =====
Plug 'rakr/vim-one'
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim'

" done installing plugins
call plug#end()

" ===== startify =====

" use unicode chars in the header
let g:startify_fortune_use_unicode = 1

let g:header_line = [
    \ '────────────────────────────────────────────────────────────────',
    \ ]

let g:post_header = [
    \ 'drop-vim by @zanderhavgaard | github.com/zanderhavgaard/drop-vim',
    \ '',
    \ '~ Happy Hacking! ~',
    \ '',
    \ ]

let g:startify_custom_header = startify#pad(startify#fortune#cowsay() + g:header_line + g:post_header)

" ===== Colorscheme // UI =====

" enable syntax highlightinh
syntax on

" use dark background
set background=dark

" use 24bit color if available
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


" set colorscheme, only use one (duh)
" colorscheme one
colorscheme gruvbox
" colorscheme dracula

" no indenline guides for startify
autocmd User Startified IndentLinesToggle

" make vertical splits look nicer
set fillchars=vert:┃ " for vsplits
set fillchars+=fold:· " for folds
hi VertSplit guifg=#2C323C

" ===== Clipboard =====

" automatically use system clipboard for all yanking and pasting
set clipboard+=unnamedplus

" ===== Custom settings =====

" highlight current line
set cursorline

" enable line numbers
set number

" enable relative line numbers
set relativenumber

" no linenumbers in terminal buffers
" TODO throws error when running in vim
if has("nvim")
    au TermOpen * setlocal nonumber norelativenumber scrolloff=0
    au TermOpen * IndentLinesToggle
endif

" always center the currnet line in the buffer
set scrolloff=999

" faster scrolling
set lazyredraw

" show current command
set showcmd

" show current mode
set showmode

" highlight matching braces
set showmatch

" wrap line at number of columns from right
" set wrapmargin=8

" set width of tabs in spaces
set tabstop=4
set shiftwidth=4
" turn off softtab / space mixing
set softtabstop=0
" expand tabs to spaces
set expandtab

" automatically use same indentation on new line
set autoindent

" enable bold fonts:
let g:enable_bold_font = 1

" enable italics
let g:enable_italic_font = 1

" ignore case when searching
set ignorecase

" move cursor to nearest match while typing
set incsearch

" automactically reload file if changed
" outside vim and there are no unsaved edits
set autoread

" trigger check if file was changed outside vim
" when then cursor stops moving
au CursorHold,CursorHoldI * :checktime
au FocusGained,BufEnter * :checktime

" auto save files on window focus loss
:au FocusLost * :wa
:au BufLeave * :wa

" auto save when switching buffers
:set autowrite

" decrease timeout so that whichkey shows faster
set timeoutlen=500

" hide statusbar when whichkey is showed
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" decrease update time such git gutter works faster
set updatetime=100

" draw indent guides for tab-indented code
set listchars=tab:\|\
set list

" more natural split opening
set splitbelow
set splitright

" enable spellchecking for .md and .tex files
autocmd FileType markdown,tex,latex,plaintex set spell

" activate limelight when entering goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" startify autoload sessions
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
" where to save vim sessions
let g:startify_session_dir = '~/.nvim/sessions'

" enable quickscope when pressing one of the following keys
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" enable tabline extension
let g:airline#extensions#tabline#enabled = 1

" TODO keep powerline?
" enale powerline fonts
let g:airline_powerline_fonts = 0

" use utf-8
set encoding=utf-8

" do not start indenLine for .md files, since it hides some text, by setting
set conceallevel=0
autocmd FileType markdown let g:indentLine_enabled=0

" configure indentline
let g:indentLine_char = '▏'
let g:indentLine_first_char = '▏'
let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_setColors = 0
" let g:indentLine_char_list = ['|', '¦', '┆', '┊','▏']

" enable rainbow parentheses
let g:rainbow_active = 1
" disable for html/xml files
autocmd FileType html,xml RainbowToggleOff
let g:rainbow_conf = {
\	'separately': {
\		'nerdtree': 0,
\	}
\}

" nerdcommenter config
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" better python highlighting, enable all features
let python_highlight_all = 1

" ===== NerdTree Settings =====

" show hidden files
let NERDTreeShowHidden = 1

" if nerdtree is the only buffer, close the vim window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" delete buffer if file is deleted
let NERDTreeAutoDeleteBuffer = 1

" style arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" make ui nicer
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" ignore folders
let NERDTreeIgnore=['\.git$', '\.terraform$', '__pycache__$']

" ===== Custom commands =====

" generate recursive list of todo comments
command Todo noautocmd vimgrep /TODO\|FIXME\|HACK/j ** | cw

" ===== Custom Keybindings =====

" neovim terminal
if has("nvim")
  " exit terminal insert mode
  tnoremap <Esc> <C-\><C-n>
  " move buffers
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l
endif

" remove one tab character back in insert mode
" inoremap <silent> <S-Tab> <C-d>

" switch buffers
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" resize buffers
nnoremap <C-A-h> :vertical resize -5<cr>
nnoremap <C-A-j> :resize +5<cr>
nnoremap <C-A-k> :resize -5<cr>
nnoremap <C-A-l> :vertical resize +5<cr>

" tab switching use alt+left/right
nnoremap <A-h> gT
nnoremap <A-l> gt
nnoremap <silent> <C-A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <C-A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
" nnoremap <silent> <C-A-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
" nnoremap <silent> <C-A-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" cycle tabs
nmap <silent> <Tab> :tabnext<CR>
nmap <silent> <S-Tab> :tabprevious<CR>

" saner goto end start/end of line
nnoremap H ^
nnoremap L $

" set the <Leader> var
let mapleader = "\<Space>"
let maplocalleader = ","

" create dictionary for which key entries
let g:which_key_map = {}

" load the dictionary
" autocmd! User vim-which-key call which_key#register(<Space>,', 'g:which_key_map')
call which_key#register('<Space>', 'g:which_key_map')

" start whichkey
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" conveniently execute macro saved to q register
nnoremap <Leader>q @q
let g:which_key_map['q'] = {'name':'execute macro in q register'}

" open a new tab
nnoremap <silent> <Leader>tt :tabnew<CR>
" open current buffer in new tab
nnoremap <silent> <Leader>tc <C-w>T
let g:which_key_map['t'] = {
      \ 'name':'+tabs',
      \ 't':'open new tab',
      \ 'c':'open current buffer in new tab',
      \}

" focus current buffer
nnoremap <silent> <Leader>ff <C-W>\|<C-W>_
" enter goyo
nnoremap <silent> <Leader>fg :Goyo 50%x90%<CR>
nnoremap <silent> <Leader>fh :Goyo <CR>
" equal size all bufffers
nmap <silent> <Leader>fe <C-w>=
let g:which_key_map['f'] = {
      \ 'name':'+focus_buffers',
      \ 'f':'focus current buffer',
      \ 'g':'focus current buffer with goyo',
      \ 'h':'toggle goyo',
      \ 'e':'equal size for all buffers',
      \}

" search and replace
nnoremap <Leader>rs :%s//gc<left><left><left>
" search and replace, but search word at caret
nnoremap <leader>rr :%s/<C-r><C-w>//gc<Left><Left><Left>
let g:which_key_map['r'] = {
      \ 'name':'+replace',
      \ 's':'search and replace',
      \ 'r':'replace word at cursor',
      \}

" remove highlighting
nnoremap <Leader><space> :let @/=""<CR>
let g:which_key_map[' '] = {'name':'Clear search highlight'}

" Colorize
nnoremap <Leader>hh :ColorHighlight<CR>
" Clear colorize
nnoremap <Leader>hc :ColorClear<CR>
let g:which_key_map['h'] = {
      \ 'name':'+Color Righlight',
      \ 'h':'highlight colors',
      \ 'c':'clear color highlight'}

" Toggle nerdtree
nnoremap <Leader>m :NERDTreeToggle<CR>
let g:which_key_map['m'] = {'name':'NERDTree'}

" open new split
nnoremap <silent> <Leader>v :vsp <CR>
let g:which_key_map['v'] = {'name':'Vertical split'}
nnoremap <silent> <Leader>b :sp <CR>
let g:which_key_map['b'] = {'name':'Horizontal split'}

" close all buffers not open in a window
nnoremap <Leader>w :Wipeout<CR>
let g:which_key_map['w'] = {
      \ 'name':'+window',
      \ 'i':'Delete hidden buffers',
      \ 'w':'Swap window'
      \}

" activate ineline git blame
nnoremap <Leader>gb :BlamerToggle<CR>
let g:which_key_map['g'] = {
      \ 'name':'+git',
      \ 'b':'toggle blame in visual mode',
      \}

" errors/spellcheck
nnoremap <Leader>sn ]s
nnoremap <Leader>sp [s
nnoremap <Leader>sc z=
nnoremap <Leader>sa zg
nnoremap <Leader>si zw
let g:which_key_map['s'] = {
      \ 'name':'errors/spelling',
      \ 'n':'next error',
      \ 'p':'previous error',
      \ 'c':'correct error',
      \ 'a':'add to dictionary',
      \ 'm':'mark as error',
      \ }

" cheatsheet
nnoremap <Leader>? :Cheat40<CR>
" TODO fix name not displaying
let g:which_key_map['?'] = {'name':'cheat sheet'}
