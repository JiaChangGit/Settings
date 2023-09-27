set nocompatible
set encoding=utf-8              " Encoding UTF-8, to use Gvim correct
set t_Co=256                    " set 256 colors
set background=dark             " 告訴 Vim 編輯器終端機的背景色
colorscheme torte
set fileencodings=utf-8,big5,ucs-bom,cp950,euc-jp,euc-kr,latinl
set nobackup
set noswapfile
set wildignore=*.swp,*.bak,*.pyc,*.class,.svn
set history=1000
syntax enable                   " enable syntax
filetype plugin indent on
set backspace=indent,eol,start  " Use the Backspace key to delete characters normally
set fileformats=unix


set shiftwidth=4            
set tabstop=4                   " A tab consumes 4 space
set expandtab                   " Tabs are spaces
set softtabstop=4               " Delete tabstop spaces when spaces are tab
" set autoindent
set smartindent


set path+=.,/usr/include,,**    " 配置檔案路徑
set hlsearch                    " Highlight search results
set incsearch                   " Instantly search while typing
set ignorecase                  " Case-insensitive search
set smartcase                   " Switch to case-sensitive search when keywords contain uppercase
set wildmenu                    " Enable wildmenu while entering tab in command mode
set wildmode=list:longest,full  " Allow full list and auto-completion in wildmenu
hi Search cterm=reverse ctermbg=none ctermfg=none
set magic                       " For regular expressions turn magic on


" Interface
set number                     " Show line number
set wrap                       " Wrap long lines
set showmatch                  " Show matching brackets when closing it
set matchtime=2                " Matching brackets highlight duration (200ms)
set showcmd                    " Show command status
set showmode
set scrolloff=5                " Start to scroll when reaching lines before the edge
se mouse=a                     " Enable mouse control in all modes
set ttymouse=xterm2            " Resolve mouse mode problem in tmux
set laststatus=2               " Show status line
set cursorline                 " Highlight current line
set cursorcolumn
hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White
set noautowrite
set shortmess=atI              " stop show ad
set novisualbell
set noerrorbells
set ruler                      " The line number at the bottom is displayed
set guifont=Courier_new:h14


hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange


" for error highlight
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline


" JSON 文字格式化 
command! JSONFormat :execute '%!python -m json.tool'
\ | :execute '%!python -c "import re,sys;chr=__builtins__.__dict__.get(\"unichr\", chr);sys.stdout.write(re.sub(r\"\\\\u[0-9a-f]{4}\", lambda x: chr(int(\"0x\" + x.group(0)[2:], 16)).encode(\"utf-8\"), sys.stdin.read()))"'
\ | :set ft=javascript
\ | :1

" XML 文字格式化
command! XMLFormat :execute '%!xmllint --format -'


" 快捷鍵配置
inoremap ;; <ESC>
" 在插入模式下，分號兩下指令、非遞歸狀態，映射為按鍵 
" 如此，就有三種退回普通模式的方法 :
" 左手 - ESC
" 右手 - ; ;
" 雙手 - Ctrl + [


" 執行程式
nmap <F5> :call CompileRun()<CR>
" 普通模式下，F5 按鍵 執行 CompileRun 涵式。
" 此函式會先存檔，然後根據副檔名的不同，使用終端機的指令執行這個檔案。
" (主要運用在 Python 的執行快捷鍵)

func! CompileRun()
        exec "w"
if &filetype == 'python'
            exec "!time python3 %"
elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
elseif &filetype == 'sh'
            :!time bash %
endif
    endfunc





" 常用的文字替代
" command! : {指令名稱} :execute '{執行動作}'
" command! Br2line :execute '%s/<br>/---/g'

" Unnamed registers are synchronized with the system clipboard
" set clipboard^=unnamed,unnamedplus