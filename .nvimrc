" .nvimrc {
" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=1 foldmethod=marker nospell:
" }

" Environment {
    silent function! OSX()
        return has('macunix')
    endfunction
    silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
" }

" Plugins {
    set nocompatible
    filetype off

    " Set the runtime path to include Plug and initialize
    call plug#begin('~/.nvim/plugged')

    " Solarized theme
    " Original 'altercation/vim-colors-solarized'
    Plug 'pricco/vim-colors-solarized'

    " vim-airline: Lean & mean status/tabline for vim that's light as air.
    " https://github.com/bling/vim-airline
    Plug 'bling/vim-airline'

    " Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder.
    " https://github.com/ctrlpvim/ctrlp.vim
    Plug 'ctrlpvim/ctrlp.vim'

    " Search local vimrc files (".lvimrc") in the tree (root dir up to current dir) and load them.
    " https://github.com/embear/vim-localvimrc
    Plug 'embear/vim-localvimrc'

    " This is an EditorConfig plugin for Vim.
    " https://github.com/editorconfig/editorconfig-vim
    Plug 'editorconfig/editorconfig-vim'

    " Numbers.vim is a plugin for intelligently toggling line numbers.
    " https://github.com/myusuf3/numbers.vim
    Plug 'myusuf3/numbers.vim'

    " A tree explorer plugin for vim.
    " https://github.com/scrooloose/nerdtree
    Plug 'scrooloose/nerdtree'

    " Commentary.vim: comment stuff out
    " https://github.com/tpope/vim-commentary
    Plug 'tpope/vim-commentary'

    " Vim plugin for the Perl module / CLI script 'ack' (ag)
    " https://github.com/mileszs/ack.vim
    Plug 'mileszs/ack.vim'

    " A plugin of NERDTree showing git status flags.
    " https://github.com/Xuyuanp/nerdtree-git-plugin
    Plug 'Xuyuanp/nerdtree-git-plugin'

    Plug 'edkolev/tmuxline.vim'

    Plug 'scrooloose/syntastic'

    Plug 'tpope/vim-fugitive'

    Plug 'majutsushi/tagbar'

    Plug 'pangloss/vim-javascript'

    Plug 'tpope/vim-haml'

    Plug 'jby/tmux.vim'

    Plug 'tpope/vim-git'

    Plug 'tacahiroy/ctrlp-funky'

    Plug 'kristijanhusak/vim-multiple-cursors'

    Plug 'nathanaelkane/vim-indent-guides'

    Plug 'mhinz/vim-signify'

    Plug 'klen/python-mode'

    Plug 'rizzatti/dash.vim'

    Plug 'digitaltoad/vim-jade'

    call plug#end()
    filetype plugin indent on
" }

" General {

    " Disable some keys {
        map <up> <nop>
        map <down> <nop>
        map <left> <nop>
        map <right> <nop>
        imap <up> <nop>
        imap <down> <nop>
        imap <left> <nop>
        imap <right> <nop>
        nnoremap Q <nop>
        noremap <space> <nop>
        sunmap <space>
    " }

    " Behavior {
        set t_Co=256                        " Number of colors
        scriptencoding utf-8                " Specify the character encoding used in the script.
        set fileformats=unix,dos,mac        " This gives the end-of-line (<EOL>) formats that will be tried when starting to edit
        let mapleader = "\<Space>"          " To define a mapping which uses the mapleader variable, the special string <Leader> can be used.
        set shell=/bin/sh
        set shortmess+=filmnrxoOtTI         " Abbrev. of messages (avoids 'hit enter')
        set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
        set virtualedit=onemore             " Allow for cursor beyond last character
        set history=1000                    " Store a ton of history (default is 20)
        set nospell                         " Spell checking off
        set hidden                          " Allow buffer switching without saving
        set backspace=indent,eol,start      " Backspace for dummies
        set incsearch                       " Find as you type search
        set hlsearch                        " Highlight search terms
        set ignorecase                      " Case insensitive search
        set smartcase                       " Case sensitive when uc present
        set autoindent                      " Indent at the same level of the previous line
        set shiftwidth=4                    " Use indents of 4 spaces
        set expandtab                       " Tabs are spaces, not tabs
        set tabstop=4                       " An indentation every four columns
        set softtabstop=4                   " Let backspace delete indent
        set grepprg=ag\ --nogroup\ --nocolor " Program to use for the |:grep| command.
        set timeout timeoutlen=1000 ttimeoutlen=100
        set clipboard=
        set nojoinspaces                    " Prevents inserting two spaces after punctuation on a join (J)
        syntax enable
        set foldlevelstart=0

        " Backups
        set backup                          " Backups are nice ...
        if has('persistent_undo')
            set undofile                    " So is persistent undo ...
            set undolevels=1000             " Maximum number of changes that can be undone
            set undoreload=10000            " Maximum number lines to save for undo on a buffer reload
        endif

        " Initialize directories {
            " Copy from https://github.com/spf13/spf13-vim/blob/3.0/.vimrc#L1041
            function! InitializeDirectories()
                let prefix = 'vim'
                let common_dir = $HOME . '/.nvim/.' . prefix
                let dir_list = {
                            \ 'backup': 'backupdir',
                            \ 'views': 'viewdir',
                            \ 'swap': 'directory' }

                if has('persistent_undo')
                    let dir_list['undo'] = 'undodir'
                endif

                for [dirname, settingname] in items(dir_list)
                    let directory = common_dir . dirname . '/'
                    if exists("*mkdir")
                        if !isdirectory(directory)
                            call mkdir(directory)
                        endif
                    endif
                    if !isdirectory(directory)
                        echo "Warning: Unable to create backup directory: " . directory
                        echo "Try: mkdir -p " . directory
                    else
                        let directory = substitute(directory, " ", "\\\\ ", "g")
                        exec "set " . settingname . "=" . directory
                    endif
                endfor
            endfunction
            call InitializeDirectories()
        " }
    " }

    " UI {
        if LINUX()
            set background=dark
            colorscheme monokai
        elseif OSX()
            set background=dark
            let g:solarized_underline=0
            let g:solarized_bold=0
            let g:solarized_italic=0
            let g:solarized_contrast='normal'
            let g:solarized_visibility='normal'
            colorscheme solarized
        endif

        set nowrap                          " Do not wrap long lines
        set whichwrap=b,s,h,l,<,>,[,]       " Backspace and cursor keys wrap too
        set showbreak=↪                     " String to put at the start of lines that have been wrapped.
        set cursorline                      " Highlight current line
        set tabpagemax=15                   " Only show 15 tabs
        set showmode                        " Display the current mode (N/A: vim-airline)
        set cmdheight=2                     " Number of screen lines to use for the command-line.
        set ruler                           " Show the ruler (N/A: vim-airline)
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids (N/A: vim-airline)
        set showcmd                         " Show partial commands in status line and Selected characters/lines in visual mode
        set showmatch                       " Show matching brackets/parenthesis
        set linespace=0                     " No extra spaces between rows (only gui)
        set number                          " Line numbers on
        set winminheight=0                  " Windows can be 0 line high
        set scrolljump=1                    " Lines to scroll when cursor leaves screen
        set scrolloff=5                     " Minimum lines to keep above and below cursor
        set sidescroll=1                    " The minimal number of columns to scroll horizontally.
        set sidescrolloff=15                " Columns on horizonal scroll
        set splitright                      " Puts new vsplit windows to the right of the current
        set splitbelow                      " Puts new split windows to the bottom of the current
        if has('statusline')
            set laststatus=2
            " Broken down into easily includeable segments (N/A: vim-airline)
            set statusline=%<%f\                     " Filename
            set statusline+=%w%h%m%r                 " Options
            set statusline+=%{fugitive#statusline()} " Git Hotness
            set statusline+=\ [%{&ff}/%Y]            " Filetype
            set statusline+=\ [%{getcwd()}]          " Current dir
            set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
        endif
        set foldenable                      " Auto fold code
        set wildmenu                        " Show list instead of just completing
        set wildmode=list:longest,full      " Command <Tab> completion, list matches, then longest common part, then all.
        set list                            " Useful to see the difference between tabs and spaces and for trailing blanks.
        set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
        set pastetoggle=<F12>               " pastetoggle (sane indentation on pastes)
        set mouse=""                        " Disable mouse
        set noerrorbells                    " Disable Ring the bell (beep or screen flash) for error messages.
        set novisualbell                    " Disable visual bell
    " }

    " Keys {

        " Wrapped lines goes down/up to next row, rather than next line in file.
        noremap j gj
        noremap k gk

         " Visual Search {

            function! CmdLine(str)
                exe "menu Foo.Bar :" . a:str
                emenu Foo.Bar
                unmenu Foo
            endfunction

            function! VisualSelection(direction) range
                let l:saved_reg = @"
                execute "normal! vgvy"

                let l:pattern = escape(@", '\\/.*$^~[]')
                let l:pattern = substitute(l:pattern, "\n$", "", "")

                if a:direction == 'b'
                    execute "normal ?" . l:pattern . "^M"
                elseif a:direction == 'gv'
                    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
                elseif a:direction == 'replace'
                    call CmdLine("%s" . '/'. l:pattern . '/')
                elseif a:direction == 'f'
                    execute "normal /" . l:pattern . "^M"
                endif

                let @/ = l:pattern
                let @" = l:saved_reg
            endfunction

            " Visual mode pressing * or # searches for the current selection
            " Super useful! From an idea by Michael Naumann
            vnoremap <silent> * :call VisualSelection('f')<CR>
            vnoremap <silent> # :call VisualSelection('b')<CR>

            " When you press gv you vimgrep after the selected text
            vnoremap <silent> gv :call VisualSelection('gv')<CR>

            " When you press <leader>r you can search and replace the selected text
            vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>


        " }

        " Paste
        vmap <Leader>y "*y
        nmap <Leader>p "*p
        nmap <Leader>P "*P
        vmap <Leader>p "*p
        vmap <Leader>P "*P

        " Code folding options
        nmap <Leader>f0 :set foldlevel=0<CR>
        nmap <Leader>f1 :set foldlevel=1<CR>
        nmap <Leader>f2 :set foldlevel=2<CR>
        nmap <Leader>f3 :set foldlevel=3<CR>
        nmap <Leader>f4 :set foldlevel=4<CR>
        nmap <Leader>f5 :set foldlevel=5<CR>
        nmap <Leader>f6 :set foldlevel=6<CR>
        nmap <Leader>f7 :set foldlevel=7<CR>
        nmap <Leader>f8 :set foldlevel=8<CR>
        nmap <Leader>f9 :set foldlevel=9<CR>

        " Quick save
        nmap <leader>w :w!<CR>

        " Find merge conflict markers
        map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

        " Visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv

        " Disable highlight when <leader><CR> is pressed
        map <silent> <Leader><CR> :noh<CR>

        " Close the current buffer
        map <Leader>bd :Bclose<CR>

        " Close all the buffers
        map <Leader>ba :1,1000 bd!<CR>

        " Switch CWD to the directory of the open buffer
        map <Leader>cd :cd %:p:h<CR>:pwd<CR>

        " Pressing ,ss will toggle and untoggle spell checking
        map <Leader>ss :setlocal spell!<CR>

        " Quickly open a buffer for scripbble
        map <Leader>q :e ~/buffer<CR>

        " Stop that stupid window from popping up
        map q: :q

    " }

    " Tabs {
        set showtabline=2
        if exists("+showtabline")
            function! TabLine()
                let s = ''
                let t = tabpagenr()
                let i = 1
                while i <= tabpagenr('$')
                    let buflist = tabpagebuflist(i)
                    let winnr = tabpagewinnr(i)
                    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
                    let bufnr = buflist[winnr - 1]
                    let s .= ' '
                    let file = bufname(bufnr)
                    let buftype = getbufvar(bufnr, 'buftype')
                    if buftype == 'nofile'
                        if file =~ '\/.'
                            let file = substitute(file, '.*\/\ze.', '', '')
                        endif
                    else
                        let file = fnamemodify(file, ':p:t')
                    endif
                    if file == ''
                        let file = '[No Name]'
                    endif
                    let s .= file
                    if getbufvar(bufnr, "&modified")
                        let s .= ' ±'
                    endif
                    let s .= ' '
                    let i = i + 1
                endwhile
                let s .= '%T%#TabLineFill#%='
                return s
            endfunction
            set tabline=%!TabLine()
        endif
    " }

    " Windows, Panes, Tabs and Splits {
        " Avoid <Esc> wait
        " http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim#2b._Mapping_.22fast.22_keycodes
        " Switch Session
        set <F13>=c
        map <silent> <F13> call system('tmux switch-client -n')
        map! <silent> <F13> call system('tmux switch-client -n')
        " Switch Window
        set <F15>=w
        map <silent> <F14> call system('tmux select-window -t :+')
        map! <silent> <F14> call system('tmux select-window -t :+')
        " Switch Pane
        set <F15>=p
        map <silent> <F15> call system('tmux select-pane -t :.+')
        map! <silent> <F15> call system('tmux select-pane -t :.+')
        " Switch Tab
        set <F16>=t
        map <F16> :tabnext<CR>
        map! t <Esc>:tabnext<CR>
        " Switch Split
        set <F17>=s
        map <F17> :wincmd w<CR>
        map! <F17> <Esc>:wincmd w<CR>
    " }
" }

" airline {
    set laststatus=2
    if LINUX()
        let g:airline_theme = 'monokai'
    elseif OSX()
        let g:airline_theme = 'solarized'
    endif
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tmuxline#enabled = 0
    let g:airline#extensions#tabline#enabled = 0
    let g:airline#extensions#bufferline#enabled = 0
" }

" CtrlP {
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': 'ag %s --nocolor -l -g ""'
    \ }
    " CtrlP extensions
    let g:ctrlp_extensions = ['funky']

    nnoremap <silent> <leader>o :CtrlP<CR>
    nnoremap <silent> <leader>fu :CtrlPFunky<CR>
" }

" Commentary {
    nmap <leader>cc <plug>CommentaryLine
    vmap <leader>cc <plug>Commentary
" }

 " NerdTree {
    nmap <leader>nt :NERDTreeToggle<CR>
    vmap <leader>nt :NERDTreeToggle<CR>
    nmap <leader>nf :NERDTreeFind<CR>
    vmap <leader>nf :NERDTreeFind<CR>
    let g:NERDTreeShowBookmarks = 1
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeWinSize = 26
    let g:NERDTreeMapActivateNode = "za"
    let g:NERDTreeChDirMode = 0
    let g:NERDTreeQuitOnOpen = 1
    let g:NERDTreeShowHidden = 1
    let g:NERDTreeKeepTreeInNewTab=1
    let g:NERDTreeIgnore = ['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '__pycache__', '.ropeproject', '.vagrant']

" }

" Ack {
    noremap <C-f> :Ack<space>
    let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
" }

" Local Vimrc {
    " TODO: Get from variable
    let g:localvimrc_whitelist = '/home/pricco/sophilabs/.*'
    let g:localvimrc_sandbox = 0
" }

" Syntastic {
    let g:syntastic_check_on_open = 0
    let g:syntastic_error_symbol = "✗"
    let g:syntastic_warning_symbol = "⚠"
    let g:syntastic_enable_highlighting = 0
    let g:syntastic_cursor_column = 0
    let g:syntastic_enable_highlighting = 0
    let g:syntastic_python_checkers = ['flake8']
    let g:syntastic_scss_checkers = []
    nnoremap <leader>l :SyntasticCheck<CR>
" }

" PythonMode  {
    let g:pymode = 1
    let g:pymode_trim_whitespaces = 1
    let g:pymode_options_max_line_length = 79
    let g:pymode_options_colorcolumn = 1
    let g:pymode_indent = 1
    let g:pymode_folding = 1
    let g:pymode_syntax = 1
    let g:pymode_motion = 0
    let g:pymode_doc = 0
    let g:pymode_virtualenv = 0
    let g:pymode_run = 0
    let g:pymode_breakpoint = 1
    let g:pymode_breakpoint_bind = '<leader>b'
    let g:pymode_lint = 0
    let g:pymode_rope = 0
    let g:pymode_syntax_slow_sync = 0
    let g:pymode_syntax_all = 1
" }

" Indent Guides {
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_default_mapping = 0
    let g:indent_guides_auto_colors  =  0
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
    nmap <silent> <Leader>ig <Plug>IndentGuidesToggle
    if OSX()
        highlight IndentGuidesOdd ctermbg=0
        highlight IndentGuidesEven ctermbg=0
        highlight NonText ctermfg=8 guifg=8
    endif
" }

" EasyMotion {
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_smartcase = 1
    nmap s <Plug>(easymotion-s2)
    nmap t <Plug>(easymotion-t2)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
" }

" Multiple Cursors {
    let g:multi_cursor_next_key = '<C-n>'
    let g:multi_cursor_prev_key = '<C-p>'
    let g:multi_cursor_skip_key = '<C-x>'
    let g:multi_cursor_quit_key = '<Esc>'
    let g:multi_cursor_start_key = '<C-n>'
" }

" Tagbar {
    nnoremap <silent> <Leader>tt :TagbarToggle<CR>
    let g:tagbar_compact = 2
    let g:tagbar_autofocus = 1
    " If using go please install the gotags program using the following
    " go install github.com/jstemmer/gotags
    " And make sure gotags is in your path
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
            \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
            \ 'r:constructor', 'f:functions' ],
        \ 'sro' : '.',
        \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
        \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
        \ }
" }

" Fugitive {
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    " Mnemonic _i_nteractive
    nnoremap <silent> <leader>gi :Git add -p %<CR>
    nnoremap <silent> <leader>gg :SignifyToggle<CR>
" }

" Signify {
    let g:signify_sign_add = '+'
    let g:signify_sign_delete_first_line = '-'
    let g:signify_sign_change = '!'
    let g:signify_sign_changedelete = '!'
    let g:signify_sign_show_count = 0
" }

" Dash {
    nmap <silent> <leader>d <Plug>DashSearch
" }

" Tmuxline {
    " .tmux.monokai.conf configuration
    if LINUX()
        let g:tmuxline_theme = 'monokai'
    elseif LINUX()
        let g:tmuxline_theme = 'solarized'
    endif
    let g:tmuxline_preset = {
          \ 'a'    : '#S',
          \ 'win'  : '#W',
          \ 'cwin' : '#W',
          \ 'x'    : '#{battery_icon} #{battery_percentage}',
          \ 'y'    : '%Y-%m-%d %H:%M',
          \ 'z'    : '#H '
          \ }
" }