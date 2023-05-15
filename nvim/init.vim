" install plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Word wrapping guides - git commits etc.
" Force the cursor onto a new line after 80 characters
set textwidth=80
" However, in Git commit messages, let’s make it 72 characters
autocmd FileType gitcommit set textwidth=72
" Colour the 81st (or 73rd) column so that we don’t type over our limit
set colorcolumn=+1
" In Git commit messages, also colour the 51st column (for titles)
autocmd FileType gitcommit set colorcolumn+=51

" js colours for jsonl
autocmd BufNewFile,BufRead *.jsonl set ft=javascript


""" ale config before it loads
" let g:ale_completion_enabled = 1
let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'markdown': ['prettier'],
\   'json': ['prettier'],
\   'css': ['prettier'],
\   'go': ['gofmt', 'goimports'],
\   'bash': ['shfmt'],
\   'sh': ['shfmt'],
\   'tf': ['terraform'],
\   'tfvars': ['terraform'],
\   'hcl': ['terraform'],
\}
let g:ale_linters = {
\   'go': ['gometalinter', 'gofmt', 'goimports', 'gopls'],
\   'bash': ['shellcheck'],
\   'zsh': ['shellcheck'],
\   'markdown': ['proselint'],
\   'text': ['proselint'],
\   'tf': ['tflint'],
\   'tfvars': ['tflint'],
\   'hcl': ['tflint'],
\}
let g:ale_fix_on_save = 1 " fix on save
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 200

" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" Install plugins
call plug#begin()

" color schemes
Plug 'whatyouhide/vim-gotham'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jjo/vim-cue'

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " gopls, other stuff


" Utils
Plug 'preservim/nerdtree' " file browser
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale' " Async Lint Engine.
Plug 'jremmen/vim-ripgrep' " RipGrep in Vim. display results in quickfix list.
" Plug 'hashivim/vim-terraform' Use ale terraform formatter instead
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'json', 'markdown', 'yaml'] } " Prettier support

" Nix
Plug 'LnL7/vim-nix', { 'for': 'nix' } " Vim configuration files for Nix.

" Git
Plug 'mhinz/vim-signify' " sign diff in first column
Plug 'tpope/vim-fugitive' " Git in vim

call plug#end()

""" general

" clipbaord
set clipboard=unnamedplus

" tabbing
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" UI
" colorscheme gotham
colorscheme dracula

set cursorline  " Highlight current line
set showmatch
set matchtime=2
set termguicolors " Enable true colors support

set completeopt+=menu,menuone " Completion

" Navigation / NERDTree
map <C-n> :NERDTreeToggle<CR>

" set spell spelllang=en_us " spellcheck

let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True color
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
