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

" ============================== UI  ========================================= "

" Enable true color support
set termguicolors

" Vim airline theme
" let g:airline_theme='space'

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
set winbl=10
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

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

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
"
set autowrite

set cursorline

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:☠,extends:▷
set list
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" only keep open buffer
command! BufOnly silent! execute "%bd|e#|bd#"


source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" =======================
" UNIVERSAL KEY MAPPINGS:
" =======================

" F3 resets search highlight
nnoremap <c-F3> :set hlsearch!<CR>

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
      Plug 'stsewd/fzf-checkout.vim'
      " Fuzzy project file search
      " Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
      Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
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
      " close other buffers (and more)
      Plug 'Asheq/close-buffers.vim'
    " >============== / UNIVERSAL PLUGINS: NATIVE VIM ===================

    " NATIVE ONLY:
    " Repeat.vim remaps . in a way that plugins can tap into it.
    Plug 'tpope/vim-repeat'
    " Center Text
    Plug 'junegunn/goyo.vim'
    " -- themes
    Plug 'artanikin/vim-synthwave84'
    Plug 'flazz/vim-colorschemes'
    Plug 'sonph/onehalf', {'rtp': 'vim/'}
    Plug 'morhetz/gruvbox'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'ericbn/vim-solarized'

    " -- git helper
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    " -- DEBUGGER --"
    Plug 'puremourning/vimspector'
    " -- linter (works with eslint)
    Plug 'dense-analysis/ale'
    " -- emulate vscode-vim stuff
    Plug 'tpope/vim-commentary'
    " -- original easymotion
    Plug 'easymotion/vim-easymotion'
    " -- typescript support
    Plug 'leafgarland/typescript-vim'
    " -- vue
    Plug 'pangloss/vim-javascript'
    " PYTHON
    " iPython support
    Plug 'jpalardy/vim-slime', { 'for': 'python' }
    Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
    " -- other
    " Make sure you use single quotes
    " On-demand loading
    " Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'tpope/vim-vinegar'

    " zooms font with + and -
    Plug 'thinca/vim-fontzoom'
    " another yankring
    Plug 'svermeulen/vim-yoink'
    " yankring with alt+p && alt+shift+p && use :yanks
    " Plug 'maxbrunsfeld/vim-yankstack'
    " airline
    Plug 'vim-airline/vim-airline'
    " airline theme
    Plug 'vim-airline/vim-airline-themes'
    " TMUX
    Plug 'christoomey/vim-tmux-navigator'
    " Vue syntax highlight
    Plug 'digitaltoad/vim-pug'
    Plug 'posva/vim-vue'
    " Clojure(Script)
    Plug 'tpope/vim-fireplace'
    " colored log file
    " start with
    " :AnsiEsc
    Plug 'powerman/vim-plugin-AnsiEsc'
    " nvim in browser
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(-1) } }

    " see tags
    Plug 'liuchengxu/vista.vim'

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
  " " use split model instead of drawer (so better netrw)
  " " http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
  " let NERDTreeHijackNetrw=1
  " " show dotfiles
  " let NERDTreeShowHidden=1
  " map <C-n> :NERDTreeToggle<CR>
  " " open current file in nerdtree
  " map <leader>n :NERDTreeToggle %<CR>

  " ------------------ iPython-cell ------------------
  "------------------------------------------------------------------------------
  " slime configuration
  "------------------------------------------------------------------------------
  " always use tmux
  let g:slime_target = 'tmux'

  " fix paste issues in ipython
  let g:slime_python_ipython = 1

  " always send text to the top-right pane in the current tmux tab without asking
  let g:slime_default_config = {
              \ 'socket_name': get(split($TMUX, ','), 0),
              \ 'target_pane': '{top-right}' }
  let g:slime_dont_ask_default = 1

  "------------------------------------------------------------------------------
  " ipython-cell configuration
  "------------------------------------------------------------------------------
  " Keyboard mappings. <Leader> is \ (backslash) by default

  " map <Leader>s to start IPython
  " nnoremap <Leader>s :SlimeSend1 ipython --matplotlib<CR>

  " map <Leader>r to run script
  nnoremap <Leader>r :IPythonCellRun<CR>

  " map <Leader>R to run script and time the execution
  nnoremap <Leader>R :IPythonCellRunTime<CR>

  " map <Leader>c to execute the current cell
  nnoremap <Leader>c :IPythonCellExecuteCell<CR>

  " map <Leader>C to execute the current cell and jump to the next cell
  nnoremap <Leader>C :IPythonCellExecuteCellJump<CR>

  " map <Leader>l to clear IPython screen
  " nnoremap <Leader>l :IPythonCellClear<CR>

  " map <Leader>x to close all Matplotlib figure windows
  nnoremap <Leader>x :IPythonCellClose<CR>

  " map [c and ]c to jump to the previous and next cell header
  nnoremap [c :IPythonCellPrevCell<CR>
  nnoremap ]c :IPythonCellNextCell<CR>

  " map <Leader>h to send the current line or current selection to IPython
  nmap <Leader>h <Plug>SlimeLineSend
  xmap <Leader>h <Plug>SlimeRegionSend

  " map <Leader>p to run the previous command
  " nnoremap <Leader>p :IPythonCellPrevCommand<CR>

  " map <Leader>Q to restart ipython
  " nnoremap <Leader>Q :IPythonCellRestart<CR>

  " map <Leader>d to start debug mode
  nnoremap <Leader>d :SlimeSend1 %debug<CR>

  " map <Leader>q to exit debug mode or IPython
  " nnoremap <Leader>q :SlimeSend1 exit<CR>
  " ------------------ /iPython-cell ------------------
  " ------------------ Vinegar ------------------
  map <C-n> <Plug>VinegarUp
  nmap <leader>n <Plug>VinegarUp
  nmap - <Plug>VinegarUp
  " disable annoying netrw keeps open
  autocmd FileType netrw setl bufhidden=wipe
  let g:netrw_fastbrowse = 0
  " Remove 'set hidden'
  set nohidden
  augroup netrw_buf_hidden_fix
      autocmd!

      " Set all non-netrw buffers to bufhidden=hide
      autocmd BufWinEnter *
                  \  if &ft != 'netrw'
                  \|     set bufhidden=hide
                  \| endif

  augroup end
  " ---------------- CAMELCASE -----------------
  " call camelcasemotion#CreateMotionMappings('<leader><leader>')
  " ---------------- YANKSTACK -----------------
  " nmap <M-p> <Plug>yankstack_substitute_older_paste
  " nmap <M-P> <Plug>yankstack_substitute_newer_paste
  " ---------------- YOINK -----------------
  " after performing a paste, cycle through history by hitting <c-n> and <c-p>
  " for it to work in VISUAL we need vim-subversive
  nmap <c-n> <plug>(YoinkPostPasteSwapBack)
  nmap <leader><c-p> <plug>(YoinkPostPasteSwapForward)
  " We also need to override the p and P keys to notify Yoink
  nmap p <plug>(YoinkPaste_p)
  nmap P <plug>(YoinkPaste_P)

  " [y/]y change current yank and preview in status bar
  nmap [y <plug>(YoinkRotateBack)
  nmap ]y <plug>(YoinkRotateForward)

  " toggling whether the current paste is formatted or not:
  " now hitting <c-=> after a paste will toggle between formatted and unformatted
  " (equivalent to using the = key)
  nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

  " cursor position will not change after performing a yank
  nmap y <plug>(YoinkYankPreserveCursorPosition)
  xmap y <plug>(YoinkYankPreserveCursorPosition)
  " ---------------- ALE ----------------------
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

  " ---------------- VIMSPECTOR -----------------
  " packadd! vimspector
  let g:vimspector_enable_mappings = 'HUMAN'
  nmap <C-F9> <Plug>VimspectorToggleBreakpoint
  nmap <F9> <Plug>VimspectorStepInto
  " mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)
  " for normal mode - the word under the cursor
  nmap <Leader>di <Plug>VimspectorBalloonEval
  " for visual mode, the visually selected text
  xmap <Leader>di <Plug>VimspectorBalloonEval

  " ---------------- FZF -----------------
  " MAIN KEYBIND
  " nnoremap <C-t> :Files<Cr>

  " fzf-checkout
  " Define a diff action using fugitive. You can use it with :GBranches diff or with :GBranches and pressing ctrl-f:
  let g:fzf_branch_actions = {
        \ 'diff': {
        \   'prompt': 'Diff> ',
        \   'execute': 'Git diff {branch}',
        \   'multiple': v:false,
        \   'keymap': 'ctrl-f',
        \   'required': ['branch'],
        \   'confirm': v:false,
        \ },
        \}
  " buffers & old files history
  " nnoremap <silent> <Leader>B :History<CR>
  " nnoremap <silent> <Leader>rb :History<CR>

  " other Keybinds
  " nnoremap <silent> <Leader>rp :FZF<CR>
  " nnoremap <silent> <Leader>r/ :BLines<CR>
  nnoremap <silent> <Leader>" :Marks<CR>
  nnoremap <silent> <Leader>L :Commits<CR>
  " nnoremap <silent> <Leader>H :Helptags<CR>
  " nnoremap <silent> <Leader>rr :History/<CR>
  " nnoremap <silent> i<Leader>r: :History:<CR>

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
  " === leaderF setup ==="
  " don't show the help in normal mode
  let g:Lf_HideHelp = 0
  let g:Lf_UseCache = 1
  let g:Lf_UseVersionControlTool = 1
  let g:Lf_IgnoreCurrentBufferName = 1
  " popup mode
  let g:Lf_WindowPosition = 'popup'
  let g:Lf_PreviewInPopup = 1
  let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
  let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

  " === leaderF shorcuts === "
  "   <ctrl>p - Browse list of buffers & files  in current directory
  "   <leader>: - Search command history
  "   <leader>; - Search for open buffers
  "   <Control-/> - Search lines in open buffer
  "   <leader>f - Search current directory (rg)
  "   <leader>*p - Search current directory for occurences of word under cursor
  "   <leader>*f - Search current directory for occurences visually selected text
  "   <leader>*r - recall last search
  "   <leader>*/ - search visually selected text literally
  "   <leader>*/ - Search open buffer for word under cursor

  " unmap <C-p>
  let g:Lf_ShortcutF = '<C-p>'

  noremap <leader>P :<C-U><C-R>=printf("Leaderf cmdHistory %s", "")<CR><CR>
  noremap <leader>: :<C-U><C-R>=printf("Leaderf cmdHistory %s", "")<CR><CR>
  " search MRU
  noremap <leader>; :<C-U><C-R>=printf("LeaderfMruCwd")<CR><CR>
  " search open BUFFER
  noremap <leader>B :<C-U><C-R>=printf("LeaderfBufferAll")<CR><CR>

  " search tag/all tags
  noremap <leader>t :<C-U><C-R>=printf("LeaderfBufTagAll")<CR><CR>
  noremap <leader>T :<C-U><C-R>=printf("Vista coc")<CR><CR>
  " search HELP
  noremap <leader><c-h> :<C-U><C-R>=printf("LeaderfHelp")<CR><CR>

")<CR><CR>
  " Control-/ weird behavior on linux: https://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim
  noremap <C-/> :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
  noremap <C-_> :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
  noremap <leader>f :<C-U><C-R>=printf("Rg ")<CR><CR>

  " noremap <leader>*/ :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
  noremap <leader>*p :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR><CR>

  xnoremap <leader>*f :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR><CR>
  noremap <leader>*r :<C-U>Leaderf! rg --recall<CR>
  " C-k / C-j are mapped to window change
  " let g:Lf_CommandMap = {'<C-p>': ['<C-k>'], '<C-n>': ['<C-j>']}
  " let g:Lf_NormalMap = {
  "       \   "_": [
  "       \      ['<C-p>', '<Up>'],
  "       \      ['<C-n>', '<Down>'],
  "       \   ],
  "       \}
  " ---------------- /leaderF --------
  " ---------------- Vista --------
  " How each level is indented and what to prepend.
  " This could make the display more compact or more spacious.
  " e.g., more compact: ["▸ ", ""]
  " Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]


  " To enable fzf's preview window set g:vista_fzf_preview.
  " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
  " For example:
  let g:vista_fzf_preview = ['right:50%']
  " Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
  let g:vista#renderer#enable_icon = 1



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
  nmap <leader>aq  <Plug>(coc-fix-current)

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
  " hover popup scroll "
  if has('nvim-0.4.3') || has('patch-8.2.0750')
            nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
            nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
            inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
            inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  endif
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
              \ 'takeover': 'never',
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
  " ---------------- FUGITIVE --------------
  nnoremap <silent> <leader>g :G <CR>
  nnoremap <silent> <leader>G :G <CR>
  command! GHistory call s:view_git_history()

  function! s:view_git_history() abort
    Git difftool --name-only ! !^@
    call s:diff_current_quickfix_entry()
    " Bind <CR> for current quickfix window to properly set up diff split layout after selecting an item
    " There's probably a better way to map this without changing the window
    copen
    nnoremap <buffer> <CR> <CR><BAR>:call <sid>diff_current_quickfix_entry()<CR>
    wincmd p
  endfunction

  function s:diff_current_quickfix_entry() abort
    " Cleanup windows
    for window in getwininfo()
      if window.winnr !=? winnr() && bufname(window.bufnr) =~? '^fugitive:'
        exe 'bdelete' window.bufnr
      endif
    endfor
    cc
    call s:add_mappings()
    let qf = getqflist({'context': 0, 'idx': 0})
    if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
      let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
      echom string(reverse(range(len(diff))))
      for i in reverse(range(len(diff)))
        exe (i ? 'leftabove' : 'rightbelow') 'vert diffsplit' fnameescape(diff[i].filename)
        call s:add_mappings()
      endfor
    endif
  endfunction

  function! s:add_mappings() abort
    nnoremap <buffer>]q :cnext <BAR> :call <sid>diff_current_quickfix_entry()<CR>
    nnoremap <buffer>[q :cprevious <BAR> :call <sid>diff_current_quickfix_entry()<CR>
    " Reset quickfix height. Sometimes it messes up after selecting another item
    11copen
    wincmd p
  endfunction
  " ------------------ /FUGITIVE -------------"
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
let g:netrw_browse_split=0  " open in prior window
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
      Plug 'stsewd/fzf-checkout.vim'
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
      " close other buffers (and more)
      Plug 'Asheq/close-buffers.vim'
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

noremap <silent><expr> <leader>/ incsearch#go(<SID>config_easyfuzzymotion())

" --------- SNEAK-----------
" 'fs': 2 character Sneak
" map fs <Plug>Sneak_s
" map Fs <Plug>Sneak_S
" let g:sneak#label = 2

" replace f and/or t with one-character Sneak?
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


" --------- RIPGREP ---------
"  Search in files, with:
"  <leader>f
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    " For use with ack.vim
    let g:ackprg = 'rg --vimgrep --no-heading'
    " shortcut: <C-p>a
    " nnoremap <C-p>a :Rg

    " Adds command :Rg
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

endif

" --------- CLOSE-BUFFERS ---------
nnoremap <silent> Q     :bd <CR>
nnoremap <silent> <leader>q     :Bdelete other<CR>
nnoremap <silent> <leader><C-q> :Bdelete menu<CR>
" ================== / UNIVERSAL PLUGINS CONFIG =================


" (Shift+) F8 rotates through TDD phases red, green, refactor
source ~/.config/nvim/tddcolors.vim

source ~/.vimrc.local
" ==== .vimrc.local EXAMPLE =======

" set relativenumber!
" set number!

" if exists('g:started_by_firenvim')
"   " make it light
"   set background=light
"   colorscheme onehalflight
"   let g:airline_solarized_bg='light'
"   " guifont to hack and larger
"   set guifont=Hack:h23
" else
"   set background=dark
"   let g:gruvbox_contrast_dark='hard'
"   let g:gruvbox_transparent_bg=1
"   colorscheme gruvbox
"   " solarized airline
"   let g:airline_solarized_bg='dark'
" endif
"
" set background transparent
" need to come after colorscheme
" set background transparent
" hi Normal guibg=NONE ctermbg=NONE
