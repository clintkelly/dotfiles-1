" Begin vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" base16-vim
Plug 'chriskempson/base16-vim'

" deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

" easymotion
Plug 'easymotion/vim-easymotion'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" nerdtree
Plug 'scrooloose/nerdtree'

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Better syntax highlighting for C++
Plug 'octol/vim-cpp-enhanced-highlight'

" vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'

Plug 'kien/ctrlp.vim'

Plug 'hashivim/vim-terraform'

Plug 'solarnz/thrift.vim'

Plug 'jelera/vim-javascript-syntax'

Plug 'jparise/vim-graphql'

" Others I may want to use:
" syntastic
" vim-javascript
" ctrlp.vim

" End vim-plug
call plug#end()

" This means that you don't have to use escape too much
" Remap esc maybe to "df"
inoremap df <ESC>

let mapleader = "\<Space>"

" Load the current base16-vim color scheme.
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace = 256

  " We have silent! here because this will only succeed once the base16-vim
  " plugin is installed.
  silent! source ~/.vimrc_background
endif

" Start nerdtree automatically on startup if no files were specified.
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if exists(':NERDTree') && argc() == 0 && !exists("s:std_in") | NERDTree | wincmd l | endif

" Close neovim automatically if the only window left open is nerdtree.
autocmd bufenter * if exists(':NERDTree') && (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Show hidden files in nerdtree.
let NERDTreeShowHidden = 1

" Disable default easymotion bindings.
let g:EasyMotion_do_mapping = 0

" Use s to jump to any character with easymotion.
nmap s <Plug>(easymotion-overwin-f)

" Use <Leader>j and <Leader>k to jump to a line with easymotion.
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" For opening files with fzf.
map <C-p> :Files<CR>

" The vim-tmux-navigator documentation recommends the following hack
" to get around a bug in macOS's terminfo for xterm-256color.
nnoremap <silent> <BS> :TmuxNavigateLeft<CR>

" Set the airline theme.
let g:airline_theme = 'base16'
let g:airline_powerline_fonts = 1

" Clear highlighting with Esc.
nnoremap <esc> :noh<return><esc>

" Show line numbers.
set number

" Insert spaces instead of tabs.
set expandtab

" Use two spaces for indentation.
set shiftwidth=2

" Don't auto-indent anything
set indentexpr=

" Show the line and column numbers of the cursor position.
set ruler

" Disable beeps.
set noerrorbells visualbell t_vb=

" Use the primary clipboard.
set clipboard=unnamed

" Set the highlight color for trailing whitespace.
highlight TrailingWhitespace ctermbg=red guibg=red

" Highlight trailing whitespace.
match TrailingWhitespace '\s\+$\|\n\+\%$'

" Wrap lines at word boundaries and make the wrapping more obvious.
set showbreak=..
set breakindent
set breakindentopt=shift:2,sbr

" Turn on spell checking everywhere.
"set spell spelllang=en_us
"syntax spell toplevel
"autocmd Syntax * :syntax spell toplevel

" Custom file type mappings
"autocmd BufNewFile,BufRead *.hql set syntax=sql
"autocmd BufNewFile,BufRead *.txt set syntax=ruby

" One of the most common things I do is set paste / set nopaste
nnoremap <Leader>p :set paste<CR>
nnoremap <Leader>P :set nopaste<CR>

" Keeps at lease ten lines above and below the cursor at all times!
set scrolloff=10

" Enables you to open files in the directory of the current buffer
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
" map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,v :vsplit <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>


set gdefault
set hlsearch
set incsearch

vmap " Simple way to turn off highlighting
"nnoremap <leader><space> :noh<cr>

" Easier options for searching
set ignorecase
set smartcase

" effect: overrides unnamed register
" Simplest version: vnoremap * y/<C-R>"<CR>
" Better one: vnoremap * y/\V<C-R>=escape(@@,"/\\")<CR><CR>
" This is so far the best, allowing all selected characters and multiline selection:
" Atom \V sets following pattern to "very nomagic", i.e. only the backslash has special meaning.
" As a search pattern we insert an expression (= register) that
" calls the 'escape()' function on the unnamed register content '@@',
" and escapes the backslash and the character that still has a special
" meaning in the search command (/|?, respectively).
" This works well even with <Tab> (no need to change ^I into \t),
" but not with a linebreak, which must be changed from ^M to \n.
" This is done with the substitute() function.
vnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>
vnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>

"Use deoplete!
"let g:deoplete#enable_at_startup = 1
