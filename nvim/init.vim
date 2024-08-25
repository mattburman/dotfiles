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
autocmd BufNewFile,BufRead *gitconfig* set ft=dosini

autocmd FileType python setlocal tabstop=8 softtabstop=8 shiftwidth=8  autoindent noexpandtab

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
\   'rust': ['rustfmt'],
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
\   'rust': ['cargo', 'analyzer'],
\}
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_fix_on_save = 1 " fix on save
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 200
autocmd BufEnter PKGBUILD,.env
    \   let b:ale_sh_shellcheck_exclusions = 'SC2034,SC2154,SC2164'

" reload configs on save
autocmd BufWritePost karabiner.edn !goku
autocmd BufWritePost kitty.conf !kill -SIGUSR1 $(pgrep -a kitty)
" autocmd BufWritePost darwin-configuration.nix !darwin-rebuild switch " todo enable with way to enter pw in vim
autocmd BufWritePost init.vim source %


" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

"""IDEAVIMCOMMON
nnoremap <Space>n :NERDTreeToggle<CR>
" remove need to shift to enter command. TODO fix clash with repeat.vim.
nnoremap ; :
vnoremap ; :
nnoremap <Space>x :x<cr>
nnoremap <Space>u :up<cr>
set hls incsearch " highlight search and incrementally while typing.
nnoremap <Space><Space> <C-w>
map tdmb A// TODO(mattb):<Space>
nnoremap <Space>i <C-i>
nnoremap <Space>o <C-o>
" swap # and * since # is one key on uk layout so prefer forward
nnoremap # *
nnoremap * #
"""IDEAVIMCOMMON

"""IDEAVIMLIKE
noremap <Space>f :Files<CR>
 " todo lang-specific
noremap zr :up<cr>:!rr<Enter>
noremap <Space>l :ALEFix<cr>
noremap <Space>b :ALEGoToDefinition<cr>

noremap <Space>e :History<cr>
noremap <Space>a :Commands<cr>
noremap <Space>r :ALERename<cr>
noremap <Space>p :ALEPopulateLocList<cr>
noremap <Space>t :up<cr>:TestNearest<cr>
noremap <Space>j :ALECodeAction<cr>
" nnoremap ss :update<cr>
"""END IDEAVIMLIKE
noremap <Space>; :History:<cr>

" would be nice if i could do this in ideavim too:
function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>



" Install plugins
call plug#begin()
"""PLUGSHARED
Plug 'preservim/nerdtree' " map to IDEA file tree bindings eg hjkl navigation etc.
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak' " Plugin must be installed manually for IDEAvim.
let g:sneak#label = 1
Plug 'unblevable/quick-scope' " Plugin must be installed manually for IDEAvim.
" Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'chrisbra/matchit'
Plug 'tpope/vim-repeat'
"""ENDPLUGSHARED

" color schemes
Plug 'whatyouhide/vim-gotham'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ayu-theme/ayu-vim' " or other package manager
"...
set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
" todo make switch to light


Plug 'jjo/vim-cue'
Plug 'TaDaa/vimade' " dim inactive
let g:vimade = {}
let g:vimade.fadelevel = 0.7

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " gopls, other stuff

 " Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
let g:vim_markdown_folding_disabled = 1
Plug 'evansalter/vim-checklist'
nnoremap <Space>c :ChecklistToggleCheckbox<cr>
vnoremap <Space>c :ChecklistToggleCheckbox<cr>

" general Languages
Plug 'nickel-lang/vim-nickel'
Plug 'NoahTheDuke/vim-just'

" Utils
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree' " file browser. also in ideavim.
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'dense-analysis/ale' " Async Lint Engine.

Plug 'vim-test/vim-test' " Smart test runner
let test#strategy = "basic" " TODO: look into floaterm strategy


" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
\  'coc-snippets',
\]


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ CheckBackspace() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <c-space> to trigger completion: >

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Use <CR> to confirm completion, use: >

inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

"To make <CR> to confirm selection of selected complete item or notify coc.nvim
" to format on enter, use:

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Map <tab> for trigger completion, completion confirm, snippet expand and jump
" like VSCode: >

inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ CheckBackspace() ? "\<TAB>" :
  \ coc#refresh()

let g:coc_snippet_next = '<tab>'


nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


Plug 'jremmen/vim-ripgrep' " RipGrep in Vim. display results in quickfix list.
" Plug 'hashivim/vim-terraform' Use ale terraform formatter instead
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'json', 'markdown', 'yaml'] } " Prettier support

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Nix
Plug 'LnL7/vim-nix', { 'for': 'nix' } " Vim configuration files for Nix.

" Rust
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
syntax enable
filetype plugin indent on

" Plug 'simrat39/rust-tools.nvim' TODO

" Git
Plug 'mhinz/vim-signify' " sign diff in first column
Plug 'tpope/vim-fugitive' " Git in vim

" Comments
Plug 'tpope/vim-commentary'

call plug#end()

" UI
colorscheme ayu


""" general

set nu
set title " terminal title
set cmdheight=1
set noshowmode " dont show INSERT / VISUAL LINE, etc
set ignorecase " in search
set mouse=a " click to move cursor
set mousemodel=popup_setpos
set smartcase " .. but not when search pattern contains upper case characters


" clipbaord
set clipboard=unnamedplus
set shellcmdflag=-ic

" tabbing
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

set cursorline  " Highlight current line
set showmatch
set matchtime=2
set termguicolors " Enable true colors support

set completeopt+=menu,menuone " Completion

" Navigation / NERDTree
Plug 'preservim/nerdtree'
map <C-n> :NERDTreeToggle<CR>

" set spell spelllang=en_us " spellcheck

let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True color
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
