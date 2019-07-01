call plug#begin('~/.vim/plugged')

Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/cscope.vim'
Plug 'octol/vim-cpp-enhanced-highlight' 
Plug 'tomasr/molokai'
Plug 'altercation/solarized'
Plug 'vim-scripts/a.vim'
Plug 'tpope/vim-fugitive'               " best Git wrapper
Plug 'flazz/vim-colorschemes'
Plug 'mileszs/ack.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'richq/vim-cmake-completion'
Plug 'w0rp/ale'
Plug 'liuchengxu/space-vim-dark'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'liuchengxu/eleline.vim'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'liuchengxu/vista.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'


call plug#end()

" =========================================================================
" 基本配置
" =========================================================================
syntax enable
syntax on
set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set mouse=a
set hlsearch
set autoindent
set expandtab
set cindent
filetype indent on
set smartindent
filetype plugin indent on 
set colorcolumn=81      " 行长
set backspace=2
set laststatus=2
" 编码
set fileencodings=utf-8,chinese,cp936,latin1
set encoding=utf-8
let &termencoding=&encoding

" 鼠标兼容
if &term =~ '^screen'
	" tmux knows the extended mouse mode
	set ttymouse=xterm2
endif



" =========================================================================
" 额外便捷快捷键
" =========================================================================
map <F7> :abo wincmd f<CR>
map <F8> :vertical wincmd f<CR>
map <F1> :q <CR>
" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" =========================================================================


" =========================================================================
" 颜色外观配置
" =========================================================================
" Solarized
" let g:rehash256 = 1
" colorscheme solarized
"
" hi Search cterm=NONE ctermfg=grey ctermbg=blue
"
" highlight Pmenu ctermbg=125 gui=bold
" highlight PmenuSel ctermbg=28 gui=bold
" highlight Search ctermbg=3 gui=bold
" highlight Pmenu guibg=brown gui=bold
"
" "Change the color of the pop out menu
" highlight Pmenu ctermbg=125 gui=bold
" highlight PmenuSel ctermbg=28 gui=bold
" highlight Search ctermbg=3 gui=bold

"ref from https://github.com/liuchengxu/space-vim-dark
set t_Co=256
colorscheme space-vim-dark
" grey comment
hi Comment guifg=#5C6370 ctermfg=59
hi pythonSelf  ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold
" =========================================================================


" =========================================================================
" 杂项
" =========================================================================
" 额外制造一些highlight-keywords，其中第一个参数是highlight-group,
" (to see all highlight-group `:highlight`)，第二个参数是search-pattern
:match Todo /SYNTAX\|NOTE\|ML-NOTE/
" Show tab & space
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
noremap <F4> :set list!<CR>
inoremap <F4> <C-o>:set list!<CR>
cnoremap <F4> <C-c>:set list!<CR>
" =========================================================================


" =========================================================================
" LeaderF 配置
" =========================================================================
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
" 浏览模式浏览当前文档的函数
noremap <F2> :LeaderfFunction!<cr>
noremap <leader>cmd :Leaderf! cmdHistory<CR>
" search word under cursor, the pattern is treated as regex, and enter normal
" mode directly
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ",expand("<cword>"))<cr>
" 利用rg来list文件，避免使用git ls-file, 因为git ls-file 无法列出submodule文件
let g:Lf_DefaultExternalTool = "rg"
let g:Lf_UseVersionControlTool = 0
" =========================================================================


" =========================================================================
" YCM 配置
" =========================================================================
" 部分参考来自[知乎专栏：韦易笑-YouCompleteMe 中容易忽略的配置]
" (https://zhuanlan.zhihu.com/p/33046090)

let g:ycm_auto_trigger = 1
" 相关语言文件中，只需要输入符号的前两个字符，即可以自动触发 **语义补全**
" （注意和符号补全的区别）
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
" 屏蔽YCM的原型预览窗口
set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 0
" 屏蔽 YCM 的诊断信息
let g:ycm_show_diagnostics_ui = 0
" 最小的identifier符号补全的起召数量
let g:ycm_min_num_identifier_candidate_chars = 2
" 从注释和字符串中也收集identifiers
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" 在字符串中也可以补全
let g:ycm_complete_in_strings=1
let g:ycm_autoclose_preview_window_after_completion = 1
" Goto configuration
" Defines where GoTo* commands result should be opened. Can take one of the following values:
" [ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab', 'new-or-existing-tab' ]
let g:ycm_goto_buffer_command = 'same-buffer'
nnoremap <leader>dc :exec("YcmCompleter GoToDeclaration")<CR>
nnoremap <leader>df :exec("YcmCompleter GoToDefinition")<CR>

" Vertical split for Goto* Command
nnoremap <leader>vdc :vs<CR>:exec("YcmCompleter GoToDeclaration")<CR>
nnoremap <leader>vdf :vs<CR>:exec("YcmCompleter GoToDefinition")<CR>

" Horizontal split for Goto* Command
nnoremap <leader>sdc :sp<CR>:exec("YcmCompleter GoToDeclaration")<CR>
nnoremap <leader>sdf :sp<CR>:exec("YcmCompleter GoToDefinition")<CR>

" Tab split for Goto* Command
nnoremap <leader><leader>dc :tab split<CR>:exec("YcmCompleter GoToDeclaration")<CR>
nnoremap <leader><leader>df :tab split<CR>:exec("YcmCompleter GoToDefinition")<CR>
"
"
"
" 不需要每次加载额外的conf时都问询一次
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '/Users/ali/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" 白名单控制
let g:ycm_filetype_whitelist = { 
			\ "c":1,
			\ "cpp":1, 
			\ "objc":1,
			\ "sh":1,
			\ "python":1,
			\ "zsh":1,
			\ }

" Normal 模型下，按K toggle显示token文档；
function! GetMyDoc()
    " 检查当前窗口是上一个编号的窗口是否为 preview-window
    for nr in range(winnr()-1, winnr())
        if getwinvar(nr, "&pvw") == 1
            " 如果是，则关掉该preview window
            pclose
            return
        endif  
    endfor
    YcmCompleter GetDoc
endfunction
nnoremap K :call GetMyDoc()<CR>
" =========================================================================


" =========================================================================
" ALE configure
" 部分参考知乎回答 https://www.zhihu.com/question/19655689/answer/142118119
" =========================================================================
let g:ale_set_highlights = 0
let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'
let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_echo_msg_error_str = '✹ Error'
let g:ale_echo_msg_warning_str = '⚠ Warning'

let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
" 如果 normal 模式下文字改变以及离开 insert 模式的时候运行 linter
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" Ignore line too long and multiple statement in oneline, indentaion is not a
" multiple of four
let g:ale_python_flake8_options = '--ignore=E501,E701,C0321,W0311,E111,E114'
let g:ale_python_pylint_options = '--ignore=E501,E701,C0321,W0311,E111,E114'
let g:ale_linters = {'python': ['flake8']}

" 自动代码格式化
" let g:ale_fixers = {
" \  'python': [
" \    'remove_trailing_lines',
" \    'isort',
" \    'ale#fixers#generic_python#BreakUpLongLines',
" \    'yapf'
" \   ]
" \}
" " let g:ale_fix_on_save = 1
" 还是先用主动触发式的格式化吧
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

" =========================================================================


" =========================================================================
" PyMode: 禁止掉大部分功能，防止和ycm冲突
" =========================================================================
"
let g:pymode_python = "python3"
let g:pymode_lint_checkers = ['pyflakes']
let g:pymode_trim_whitespaces = 0
let g:pymode_options = 0
let g:pymode_rope = 0

let g:pymode_indent = 1
let g:pymode_folding = 0
let g:pymode_options_colorcolumn = 1
let g:pymode_breakpoint_bind = '<leader>br'

let g:pymode_lint = 0
" 禁止pymode中显示document的方式，利用ycm的getdoc来做
let g:pymode_doc = 0
" =========================================================================



" =========================================================================
" Vista: (https://github.com/liuchengxu/vista.vim)
" =========================================================================
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1
" " Set the executive for some filetypes explicitly. Use the explicit executive
" " instead of the default one for these filetypes when using `:Vista` without
" " specifying the executive.
let g:vista_executive_for = {
  \ 'php': 'vim_lsp',
  \ }
noremap <F3> :Vista!!<cr>
" =========================================================================


" =========================================================================
" vim-lsp
" =========================================================================
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
