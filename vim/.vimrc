" Tab stuff
set tabstop=4
set expandtab
set smartindent
set shiftwidth=4

" Map SemiColon to Colon and Colon to SemiColon. Way better.
nnoremap ; :
nnoremap : ;

" Show commands as you type
set showcmd

" Tab completing
set wildmenu
set wildmode=list:longest,full

" Line Numbers
set number

" Awesome searching
set ignorecase
set smartcase

syntax on

" Next Tab - Ctrl-Right Arrow
nnoremap <silent> <C-Right> :tabnext<CR>
" Previous Tab - Ctrl-Left Arrow
nnoremap <silent> <C-Left> :tabprevious<CR>
" New Tab - Ctrl-T
nnoremap <silent> <C-t> :tabnew<CR>

" Edit vimrc by typing \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e C:\Program\ Files\ (x86)\vim\_vimrc<CR>

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
nnoremap JJJJ <Nop>

exec "set listchars=tab:^-,trail:\uB7,nbsp:~"
"exec "set listchars=tab:\ \ ,trail:\uB7,nbsp:~"
set list

set foldmethod=indent
" This is dumb, need a way to change it based on language, some .vim
" syntax or something
set foldnestmax=4
set foldlevelstart=2
" set foldlevel=8

set hlsearch

nnoremap <space> za

vnoremap <space> zf

" Color scheme, normal is default
colorscheme darkzen

filetype plugin on

runtime! ftplugin/man.vim
