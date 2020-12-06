" ==================
" GLOBAL SETTINGS:
" ==================

" NOCOMPATIBLE:
" enter the current millenium, vi not used
set nocompatible

"
" LEADER IS "SPACE" AND "\":
" ==========================
" --------------------------
" for <leader><leader> use \ \
" --------------------------
" (eg. \\w for easymotion-w)
" --------------------------
"
" Must stand before other uses
" Maps leader to \
let mapleader="\\"
" Map SPACE to None
" Without that, pressing <Space> will not behave like other keys as mapleader.
" <Space> in normal mode is mapped to <right>.
" Just press <space> a couple of times in a row and you will see undesired behaviour.
nnoremap <Space> <Nop>
" Maps SPACE to \
map <Space> \
" Exclude in select mode, so space can be used to replace
" placeholder text in a snippet.
sunmap <Space>

" Ctrl+Space removes Space leader lag for multiple Space inserts
inoremap <C-Space> <leader>

" INSTALL PLUGVIM:
" ==================
" automagically install plug.vim
" only on linux
if !has('win32')
  if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
      echo "Downloading junegunn/vim-plug to manage plugins..."
      silent !mkdir -p ~/.config/nvim/autoload/
      silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
      autocmd VimEnter * PlugInstall
  endif
endif

" ==================
" FROM: HOW TO DO NINETY PERSENT OF WHAT PLUGINS DO WITH JUST VIM:
" ==================
" https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
" https://www.youtube.com/watch?v=XA2WjJbmmoM

" BASIC SETUP:
" ==================
" enable syntax and plugins
syntax enable

" FINDING FILES:
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" https://stackoverflow.com/questions/1457540/how-to-navigate-in-large-project-in-vim
" FOR SLOWER MACHINES: (enable in vimrc.local)
" Set the working directory to wherever the open file lives
" set autochdir
" set path=$PWD/**

" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*

" Show all matching files above the command line when tab complete
" from: https://gist.github.com/csswizardry/9a33342dace4786a9fee35c73fa5deeb
set wildmenu
" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer
" - split :vs **/*<partial file name><Tab>
" - :e **
" Now we’re at a point where I don’t need to look through any directories
" If I know I want to open my `_components.buttons.scss` file I just need to do:
" :vs **/*butto<Tab>


" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" NATIVE AUTOCOMPLETE IN INSERT MODE:
" ===================================
" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" (needs to be in INSERT MODE)
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option
" - ^e Exist insert mode with keeping stuff you written before

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list

" =======================
" UNIVERSAL VIM SETTINGS:
" =======================
" from various sources over time

" Terminal Mode: Escape with SHIFT+ESC
:tnoremap <C-\><Esc> <C-\><C-n>
" set vim swap directory
set directory=~/.vim/swap
  if empty(glob('~/.vim/swap'))
    silent !mkdir -p ~/.vim/swap
  endif
" disable swapfile
set noswapfile
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" yank to windows clipboard
" on linux install xclip
set clipboard=unnamedplus
" if (executable('pbcopy') || executable('xclip') || executable('xsel')) && has('clipboard')
"   set clipboard=unnamed
" endif
" automatically refresh any files that haven't been edited by Vim
set autoread
" hides buffer instead of closing it
set hidden
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" you get relative numbers for all lines except the current, which is displayed as absolute.
set relativenumber
set number
" tabs
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
" set english Language
" for menu
set langmenu=en_US
" for everyhere
let $LANG = 'en_US'
" save on focus lost
au FocusLost * silent! wa
" save on buffer switch
set autowrite

set cursorline




source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" =======================
" UNIVERSAL KEY MAPPINGS:
" =======================

" F3 resets search highlight
nnoremap <F3> :set hlsearch!<CR>

" exit insert mode without ESC
" native, but with delay
imap jk <Esc>
imap kj <Esc>

" Paste in visual mode without yanking the old value
" like `xnoremap p pgvy` but works with register
" xnoremap p pgv"@=v:register.'y'<cr>
" xnoremap <expr> p 'pgv"'.v:register.'y`>'

" replace currently selected text with default register
" without yanking it
" vnoremap <leader>p "_dP

" delete without yanking
" vnoremap <leader>d "_d

" When you move the cursor down (or up), the cursor will jump from one visual line to the next. Normally you can press j to move down one physical line, or gj to move down one displayed line.
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" ============== only NATIVE VIM  ===================
if !exists('g:vscode')
  " -------------- PLUGINS NATIVE VIM -------------------
  call plug#begin('~/.vim/plugged')
    " UNIVERSAL:
    " >============== UNIVERSAL PLUGINS: NATIVE VIM ===================
      " ------ needs to be duplicated because can't call plug#begin twice
      Plug 'bkad/CamelCaseMotion'
      " Fuzzy Find, use :ctrlp or <c-p>
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
      Plug 'junegunn/fzf.vim'
      " Easymotion fuzzy search
      Plug 'haya14busa/incsearch.vim'
      Plug 'haya14busa/incsearch-fuzzy.vim'
      Plug 'haya14busa/incsearch-easymotion.vim'
      " - helps with f scoping
      Plug 'unblevable/quick-scope'
      " no visual delay after jk / kj
      Plug 'zhou13/vim-easyescape'
      Plug 'justinmk/vim-sneak'
      " Surround
      Plug 'tpope/vim-surround'
      " unimpaired ([p,]p etc)
      Plug 'tpope/vim-unimpaired'
      " fish file editing
      Plug 'dag/vim-fish'
    " >============== / UNIVERSAL PLUGINS: NATIVE VIM ===================

    " NATIVE ONLY:
    " -- git helper
    Plug 'tpope/vim-fugitive'
    " -- linter (works with elint)
    Plug 'dense-analysis/ale'
    " -- emulate vscode-vim stuff
    Plug 'sonph/onehalf', {'rtp': 'vim/'}
    Plug 'ericbn/vim-solarized'
    Plug 'tpope/vim-commentary'
    " -- original easymotion
    Plug 'easymotion/vim-easymotion'
    " -- typescript support
    Plug 'leafgarland/typescript-vim'
    " -- vue
    Plug 'posva/vim-vue'
    Plug 'pangloss/vim-javascript'
    " -- other
    " Make sure you use single quotes
    " On-demand loading
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    " zooms font with + and -
    Plug 'thinca/vim-fontzoom'
    " yankring with alt+p && alt+shift+p && use :yanks
    Plug 'maxbrunsfeld/vim-yankstack'
    " airline
    Plug 'vim-airline/vim-airline'
    " airline theme
    Plug 'vim-airline/vim-airline-themes'
    " TMUX
    Plug 'christoomey/vim-tmux-navigator'
    " Clojure(Script)
    Plug 'digitaltoad/vim-pug'
    " Clojure(Script)
    Plug 'tpope/vim-fireplace'
    " colored log file
    " start with
    " :AnsiEsc
    Plug 'powerman/vim-plugin-AnsiEsc'
    " nvim in browser
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(-1) } }

    " AUTOCOMPLETION: basially port of vscode autocompletion
    " https://github.com/neoclide/coc.nvim
    if has('win32')
      Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.cmd'}
    else
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif
  call plug#end() " /Initialize plugin system

  " ----------------
  " NATIVE SETTINGS:
  " ----------------

  " SPLITS:
  " ----------------
  " MOVE BETWEEN SPLITS OR WINDOWS:
  " more naturally with CTLR+jklw
  " close is <C-W>Q
  nnoremap <C-j> <C-W><C-J>
  nnoremap <C-k> <C-W><C-K>
  nnoremap <C-l> <C-W><C-L>
  nnoremap <C-h> <C-W><C-H>

  "Open new split panes to right and bottom, which feels more natural than Vim’s default:
  set splitbelow
  set splitright

  " == CHEATSHEET =="
  " RESIZING SPLITS:
  " Max out the height of the current split
  " ctrl + w _
  " Max out the width of the current split
  " ctrl + w |
  " Normalize all split sizes, which is very handy when resizing terminal
  " ctrl + w =
  " MORE SPLIT MANIPULATION:
  " Swap top/bottom or left/right split
  " Ctrl+W R
  " Break out current window into a new tabview
  " Ctrl+W T
  "Close every window in the current tabview but the current one
  " Ctrl+W o


  " correct syntax highlight of // comments in .json files
  autocmd FileType json syntax match Comment +\/\/.\+$+
  " show cmd in right bottom
  set showcmd


  " LOCAL THEMES:
  " "(only put into vimrc.local)
  " " set solarized theme
  " colorscheme solarized
  " " make it light
  " set background=light
  " " solarized airline
  " let g:airline_solarized_bg='dark'
  " " guifont to hack and larger
  " set guifont=Hack:h16

  " NATIVE MAPPINGS:
  " ----------------

  " CONFIG NATIVE PLUGINS:
  " ----------------------
  " ------------------ NERDTREE ------------------
  " use split model instead of drawer (so better netrw)
  " http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
  let NERDTreeHijackNetrw=1
  " show dotfiles
  let NERDTreeShowHidden=1
  map <C-n> :NERDTreeToggle<CR>

  " ---------------- CAMELCASE -----------------
  " call camelcasemotion#CreateMotionMappings('<leader><leader>')
  " ---------------- YANKSTACK -----------------
  nmap <M-p> <Plug>yankstack_substitute_older_paste
  nmap <M-P> <Plug>yankstack_substitute_newer_paste
  " ---------------- ALEl ----------------------
  " fix files on save
  let g:ale_fix_on_save = 1

  " disable because of coc
  let g:ale_disable_lsp = 1

  " lint after 1000ms after changes are made both on insert mode and normal mode
  let g:ale_lint_on_text_changed = 'always'
  let g:ale_lint_delay = 1000

  " use nice symbols for errors and warnings
  let g:ale_sign_error = '>>'
  let g:ale_sign_warning = '⚠ '

  " fixer configurations
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'javascript': ['prettier', 'eslint']
  \}
  " ---------------- FZF -----------------
  " MAIN KEYBIND
  nnoremap <C-p> :Files<Cr>

  " buffers & old files history
  nnoremap <silent> <Leader>B :History<CR>
  nnoremap <silent> <Leader>rb :History<CR>

  " other Keybinds
  nnoremap <silent> <Leader>rp :FZF<CR>
  nnoremap <silent> <Leader>r/ :BLines<CR>
  nnoremap <silent> <Leader>' :Marks<CR>
  nnoremap <silent> <Leader>g :Commits<CR>
  nnoremap <silent> <Leader>H :Helptags<CR>
  nnoremap <silent> <Leader>rr :History/<CR>
  nnoremap <silent> <Leader>r: :History:<CR>

  " An action can be a reference to a function that processes selected lines
  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }


  " Default fzf layout
  " - down / up / left / right
  let g:fzf_layout = { 'down': '~40%' }

  " You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
  let g:fzf_layout = { 'window': 'enew' }
  let g:fzf_layout = { 'window': '-tabnew' }
  let g:fzf_layout = { 'window': '10new' }

  " Customize fzf colors to match your color scheme
  " - fzf#wrap translates this to a set of `--color` options
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

  " Enable per-command history
  " - History files will be stored in the specified directory
  " - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
  "   'previous-history' instead of 'down' and 'up'.
  let g:fzf_history_dir = '~/.local/share/fzf-history'

  " ---------------- / FZF ------------
  " ---------------- COC ------------
  " coc config
  " automatically installs this coc extension
  " probably needs restart, check with <leader>e
  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-vetur',
    \ 'coc-prettier',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-vetur',
    \ ]
  "  TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  " actually don't know patch number, just know not working with nvim 0.2
  if has('patch8.1.1068')
    set signcolumn=yes
  endif

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  nnoremap <silent> gh :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>=  <Plug>(coc-format-selected)
  nmap <leader>=  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current line.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " coc-tsserver, coc-python are the examples of servers that support it.
  xmap <silent> <TAB> <Plug>(coc-range-select)
  " don't use TAB in normal mode, it blocks CTRL-I
  " nmap <silent> <TAB> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings using CoCList:
  " Show all diagnostics.
  nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>-----
  " ---------------- /COC ------------
  " ----------------- AIRLINE ---------------
  let g:airline#extensions#tabline#enabled = 1

  " ---------------- FIRENVIM --------------
  let g:firenvim_config = {
      \ 'globalSettings': {
      \  },
      \ 'localSettings': {
          \ '.*': {
              \ 'cmdline': 'firenvim',
              \ 'priority': 0,
              \ 'selector': 'textarea',
              \ 'takeover': 'nonempty',
          \ },
      \ }
  \ }
  let fc = g:firenvim_config['localSettings']
  if exists('g:started_by_firenvim')
    let g:airline_disable_statusline = 1
    let g:airline#extensions#tabline#enabled = 0
    " automatically syncing changes to the page
    " https://github.com/glacambre/firenvim
    au TextChanged * ++nested write
    au TextChangedI * ++nested write
  endif
endif
" ============== / only NATIVE VIM  ===================

" ==== CURRENTLY UNUSED (from 90% without plugin) =====

" TAG JUMPING:
" ==================

" Create the `tags` file (may need to install ctags first)
" command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" SNIPPETS:
" =========

" EXAMPLE:
" Make an empty HTML template and move cursor to title
" nnoremap <leader>html :-1read $HOME/.vim/.skeleton.html<CR>3jw

" NOW WE CAN:
" - Take over the world!
"   (with much fewer keystrokes)

" FILE BROWSING:
" ==============

" (for netrw)
" keeping it on for nerdtree to highjack
filetype plugin on

" (still using NERDTREE as well, because of a lot of bugs in netrw)
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" BUILD INTEGRATION:
" ==================

" Steal Mr. Bradley's formatter & add it to our spec_helper
" http://philipbradley.net/rspec-into-vim-with-quickfix

" Configure the `make` command to run RSpec
" set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter

" NOW WE CAN:
" - Run :make to run RSpec
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back
" ==== /CURRENTLY UNUSED (from 90% without plugin) =====

" ============== VSCODE-NEOVIM ===================
if exists('g:vscode')
  " -------------- PLUGINS VSCODE -------------------
  call plug#begin('~/.vim/plugged')
    " ============== UNIVERSAL PLUGINS: VSCODE-NEOVIM ===================
    " ------ needs to be duplicated because can't call plug#begin twice
      Plug 'bkad/CamelCaseMotion'
      " Fuzzy Find, use :ctrlp or <c-p>
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
      Plug 'junegunn/fzf.vim'
      " Easymotion fuzzy search
      Plug 'haya14busa/incsearch.vim'
      Plug 'haya14busa/incsearch-fuzzy.vim'
      Plug 'haya14busa/incsearch-easymotion.vim'
      " - helps with f scoping
      Plug 'unblevable/quick-scope'
      " no visual delay after jk / kj
      Plug 'zhou13/vim-easyescape'
      Plug 'justinmk/vim-sneak'
      " Surround
      Plug 'tpope/vim-surround'
      " unimpaired ([p,]p etc)
      Plug 'tpope/vim-unimpaired'
      " fish file editing
      Plug 'dag/vim-fish'
    " ============== / UNIVERSAL PLUGINS: VSCODE-NEOVIM ===================
    " Special easymotion fork (only working in VSCode)
    Plug 'asvetliakov/vim-easymotion'
  call plug#end()
  " use VSCode built-in commentary instead of plug
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  " window navigate like with tmux plugin
  xnoremap <silent> <C-j> :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
  nnoremap <silent> <C-k> :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
  xnoremap <silent> <C-k> :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
  nnoremap <silent> <C-h> :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
  xnoremap <silent> <C-h> :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
  nnoremap <silent> <C-l> :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
  xnoremap <silent> <C-l> :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

  " unset clipboard for remote work
  " set clipboard=

  " don't display line numbers
  set relativenumber!
  set number!
endif
" ============== / VSCODE-NEOVIM ===================

" ================== UNIVERSAL PLUGINS CONFIG =================
" ------------------ CAMELCASEMOTION ------------------
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" don't use this, muscle memory already too strong
" omap <silent> iw <Plug>CamelCaseMotion_iw
" xmap <silent> iw <Plug>CamelCaseMotion_iw
" omap <silent> ib <Plug>CamelCaseMotion_ib
" xmap <silent> ib <Plug>CamelCaseMotion_ib
" omap <silent> ie <Plug>CamelCaseMotion_ie
" xmap <silent> ie <Plug>CamelCaseMotion_ie


imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_b
imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w

" ----------- EASYMOTIONS ----------------
" change easymotion trigger back to leader instead of leader leader
" map <Leader> <Plug>(easymotion-prefix)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)
map <Leader>e <Plug>(easymotion-e)

" ----------- FUZZYSEACH (<Space>/) ----------------
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

" --------- SNEAK-----------
" 'fs': 2 character Sneak
" map fs <Plug>Sneak_s
" map Fs <Plug>Sneak_S
" let g:sneak#label = 2

" replace f and/or t with one-character Sneak?
map f <Plug>Sneak_f
map <Leader>f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


" --------- RIPGREP ---------
"  Search in files, with:
"  CTRL+P a
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    " For use with ack.vim
    let g:ackprg = 'rg --vimgrep --no-heading'
    " shortcut: <C-p>a
    nnoremap <C-p>a :Rg

    " Adds command :Rg
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

endif
" ================== / UNIVERSAL PLUGINS CONFIG =================


" (Shift+) F8 rotates through TDD phases red, green, refactor
source ~/.config/nvim/tddcolors.vim

source ~/.vimrc.local
" ==== .vimrc.local EXAMPLE =======
" if exists('g:started_by_firenvim')
" " " make it light
"   set background=light
"   colorscheme onehalflight
"   let g:airline_solarized_bg='light'
" else
"   set background=dark
"   colorscheme onehalfdark
"   " " solarized airline
"   let g:airline_solarized_bg='dark'
" endif
" " " guifont to hack and larger
" set guifont=Hack:h12
