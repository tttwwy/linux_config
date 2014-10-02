if has("syntax")
	syntax on
	set hlsearch
endif
set t_Co=256 "打开256色支持
set guifont=Mono\ 13
colorscheme darkburn
set backspace=2              " 设置退格键可用
set ai " 设置自动缩进
set smartindent " 智能自动缩进
set shiftwidth=4 " 换行时行间交错使用4空格
set nu  " 显示行号
set mouse=v" 启用鼠标
set ruler   " 右下角显示光标位置的状态行
set showcmd" Show (partial) command in status line.
set showmatch" 显示括号配对情况
set incsearch "输入搜索内容时 动态的显示搜索结果
set hlsearch "搜索内容高亮显示
set nocompatible             " 关闭兼容模式
set hidden                   " 允许在有未保存的修改时切换缓冲区
set autochdir                " 设定文件浏览器目录为当前目录
set noswapfile      "禁止交换文件swp
set cursorline
set keymodel=startsel,stopsel
set tabstop=4
set autoread
set sm
set cin
set sw=4
set encoding=utf-8
set fenc=utf-8
set fileencodings=utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"设置打开一个文件时候，猜测的文件编码列表 按照顺序来猜测
filetype plugin on
filetype plugin indent on    " 启用自动补全
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
map <F2> :NERDTreeToggle<CR>          "映射F2打开/关闭NERDtree插件
imap <F2> <ESC>:NERDTreeToggle<CR>
map <F3> :TlistToggle<CR>             "映射F3打开/关闭TagList插件
imap <F3> <ESC>:TlistToggle<CR>
"映射复制、粘贴、剪贴ctrl+c ctrl+v ctrl+x
:map <C-V> "+pa<Esc>
:map! <C-V> <Esc>"+pa
:map <C-C> "+y
:map <C-X> "+x
" 映射全选 ctrl+a
:map <C-A> ggVG
:map! <C-A> <Esc>ggVG
map <S-F> gg=G
map! <S-C-F> <C-C>gg=Gi
nmap <C-z> <Esc>:Setcomment<CR>
imap <C-z> <Esc>:Setcomment<CR>
vmap <C-z> <Esc>:SetcommentV<CR>
map <F5> :call CompileRun()<CR>
map <C-F5> :call Debug()<CR>
map <C-F12> :w<CR>:!sudo ~/oslab/mount-hdc<CR>
map <F12> :w!<CR>:!cd ~/oslab/linux-0.11/ && make clean && make<CR>:!~/oslab/run<CR>
let g:miniBufExplMapWindowNavVim = 1  "用<C-h,j,k,l>切换到上下左右的窗口中去
"set AutoComand New file title
autocmd BufNewFile *.c,*.sh,*.cpp,*.java exec ":call SetTitle()"
"set cursor to the end of the file
autocmd BUfNewFile * normal G
"set Java autofill
au FileType java setlocal omnifunc=javacomplete#CompleteParamsInfo
setlocal completefunc=javacomplete#CompleteParamsInfo
"设置折叠
set fdm=marker
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
func CompileRun()
exec "w"
if &filetype == 'c'
	exec "!gcc % -g -o %<"
	exec "!./%<"
elseif &filetype == 'cpp'
	exec "!g++ % -g -o %<"
	exec "!./%<"
elseif &filetype == 'java'
	exec "!javac %"
	exec "!java %<"
elseif &filetype == 'python'
	exec "!python %"
endif
endfunc
func Debug()
exec "w"
if &filetype == 'c'
exec "!gcc % -g -o %<"
exec "!gdb %<"
elseif &filetype == 'cpp'
exec "!g++ % -g -o %<"
exec "!gdb %<"
elseif &filetype == 'java'
exec "!javac %"
exec "!jdb %<"
endif
endfunc
func SetTitle()
if &filetype == 'c'
call setline(1,"#include <stdio.h>")
call append(line("."),"#include <math.h>")
call append(line(".")+1,"#include <string.h>")
elseif &filetype == 'cpp'
call setline(1,"#include <iostream>")
call append(line("."),"#include <cstdio>")
call append(line(".")+1,"#include <cmath>")
call append(line(".")+2,"#include <cstring>")
call append(line(".")+3,"using namespace std;")
elseif &filetype == 'java'
call setline(1,"import java.util.*;")
call append(line("."),"import java.lang.*;")
endif
endfunc
"功能说明:加入或删除注释//
"映射和绑定
command! -nargs=0 Setcomment call s:SET_COMMENT()
command! -nargs=0 SetcommentV call s:SET_COMMENTV()
"非视图模式下所调用的函数
function! s:SET_COMMENT()
let lindex=line(".")
let str=getline(lindex)
"查看当前是否为注释行
let CommentMsg=s:IsComment(str)
call s:SET_COMMENTV_LINE(lindex,CommentMsg[1],CommentMsg[0])
endfunction
"视图模式下所调用的函数
function! s:SET_COMMENTV()
let lbeginindex=line("'<") "得到视图中的第一行的行数
let lendindex=line("'>") "得到视图中的最后一行的行数
let str=getline(lbeginindex)
"查看当前是否为注释行
let CommentMsg=s:IsComment(str)
"为各行设置
let i=lbeginindex
while i<=lendindex
call s:SET_COMMENTV_LINE(i,CommentMsg[1],CommentMsg[0])
let i=i+1
endwhile
endfunction
"设置注释
"index:在第几行
"pos:在第几列
"comment_flag: 0:添加注释符 1:删除注释符
function! s:SET_COMMENTV_LINE( index,pos, comment_flag )
let poscur = [0, 0,0, 0]
let poscur[1]=a:index
let poscur[2]=a:pos+1
call setpos(".",poscur) "设置光标的位置
if a:comment_flag==0
"插入//
if &filetype == 'c'|| &filetype == 'h'
exec "normal! i/*"
exec "normal! A*/"
endif
if &filetype == 'cpp' || &filetype == 'php'
exec "normal! i//"
endif
else
"删除//
if &filetype == 'c'
exec "normal! xx$xx"
endif
if &filetype == 'cpp' || &filetype == 'php'
exec "normal! xx"
endif
endif
endfunction
"查看当前是否为注释行并返回相关信息
"str:一行代码
function! s:IsComment(str)
let ret= [0, 0] "第一项为是否为注释行（0,1）,第二项为要处理的列，
let i=0
let strlen=len(a:str)
while i<strlen
"空格和tab允许为"//"的前缀
if !(a:str[i]==' ' ||    a:str[i] == '  ' )
let ret[1]=i
if a:str[i]=='/'
let ret[0]=1
else
let ret[0]=0
endif
return ret
endif
let i=i+1
endwhile
return [0,0]  "空串处理
endfunction
"自动补全括号
:inoremap ( ()<esc>i
:inoremap ) <c-r>=ClosePair(')')<cr>
:inoremap { {<cr>}<esc>O
:inoremap } <c-r>=ClosePair('}')<cr>
:inoremap [ []<esc>i
:inoremap ] <c-r>=ClosePair(']')<cr>
:inoremap " ""<esc>i
:inoremap ' ''<esc>i
function! ClosePair(char)
if getline('.')[col('.') - 1] == a:char
return "\<right>"
else
return a:char
endif
endfunction
