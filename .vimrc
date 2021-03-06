"------------------------------------------------------------------------------"
"--------------------------------- Global -------------------------------------"
"------------------------------------------------------------------------------"
"
"--------------------------------- Vundle -------------------------------------"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'godlygeek/tabular'
Plugin 'groenewege/vim-less'
Plugin 'evidens/vim-twig'
Plugin 'tobyS/vmustache'
Plugin 'tobyS/pdv'
Plugin 'Shougo/unite.vim'
Plugin 'tsukkee/unite-tag'
Plugin 'docteurklein/php-getter-setter.vim'
Plugin 'spf13/vim-autoclose'
Plugin 'altercation/vim-colors-solarized.git'

call vundle#end()            " required
filetype plugin indent on    " required

"--------------------------------- General ------------------------------------"
"Indent
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

"Scroll
set scrolloff=15

"hlsearch
set hlsearch incsearch

"Set <backspace> free
set backspace=start,indent,eol

"Code folding
set foldmethod=manual

"lowercase search = case insensitive
"search with at least one uppercase letter : case sensitive
set ignorecase
set smartcase

" My custom color scheme
syntax enable
let g:solarized_termcolors=16
se t_Co=16
colorscheme jite_solarized

"--------------------------------- Global remap -------------------------------"
"remap leader
let mapleader = ','
"paste mode toggle
nnoremap <leader>p :set paste!<cr>
"line numbers toggle
nnoremap <leader>l :set number!<cr>
"add quotes to current word
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
"Shortcut for tabnew
nnoremap <leader>tn :tabnew<cr>
"Set mouse
nnoremap <leader>m :set mouse=a<cr>
nnoremap <leader>mm :set mouse=<cr>
" Remove trailing spaces
nnoremap <leader>s :%s/\s\+$//<CR>

"--------------------------------- Vimrc --------------------------------------"
"Opens vimrc in a new tab
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
"Applies changes to vimrc so they are usable immediately
nnoremap <leader>sv :source $MYVIMRC<cr>

"--------------------------------- General Plugins config ---------------------"
nnoremap <leader>n :NERDTreeToggle<cr>
filetype plugin on

"------------------------------------------------------------------------------"
"--------------------------------- Filetypes ----------------------------------"
"------------------------------------------------------------------------------"

"--------------------------------- XML ----------------------------------------"
" Indent xml
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

"--------------------------------- HTML/CSS/JS --------------------------------"
" Autocompletion
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"--------------------------------- Php ----------------------------------------"
" Autocompletion
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
let g:phpcomplete_index_composer_command="composer"

" PHP documenter
let g:pdv_template_dir = $HOME ."/.vim/tools/pdv/templates"
nnoremap <buffer> <leader>pd :call pdv#DocumentCurrentLine()<CR>

let b:phpgetset_getterTemplate = 
  \ "    \n" .
  \ "    /**\n" .
  \ "     * Get %varname%.\n" .
  \ "     *\n" .
  \ "     * @return %varname%.\n" .
  \ "     */\n" .
  \ "    public function %funcname%()\n" .
  \ "    {\n" .
  \ "        return $this->%varname%;\n" .
  \ "    }"

let b:phpgetset_setterTemplate = 
  \ "    \n" .
  \ "    /**\n" .
  \ "     * Set %varname%.\n" .
  \ "     *\n" .
  \ "     * @param %varname% the value to set.\n" . 
  \ "     */\n" .
  \ "    public function %funcname%($%varname%)\n" .
  \ "    {\n" .
  \ "        $this->%varname% = $%varname%;\n" .
  \ "        return $this;\n" .
  \ "    }"

" Autoremove trailing spaces on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType php autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Generate ctags for Symfony project
" nnoremap <leader>ct :!ctags -R --languages=php --php-kinds=cif --exclude=.git/* --exclude=app/* --exclude=bin/* --exclude=web/* --exclude=tests/* --exclude=*/Test/* --exclude=*/Tests/* --exclude=*test* --exclude=*Form/Type* --exclude=vendor/*/vendor
"
" Generate ctags for php project, with patched ctags
nnoremap <leader>ct :!ctags -R --fields=+aimS --languages=php

" Autoclose preview window when leaving insert mode / when moving in insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"  Shortcuts
ia vd var_dump();
ia vdd var_dump();die;

let php_sql_query = 1 "Coloration des requetes SQL

"------------------------------------------------------------------------------"
"--------------------------------- Various ------------------------------------"
"------------------------------------------------------------------------------"
"
" Checks the syntax group the current word belongs to
nnoremap <leader>syn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"----------------------------- Unite ------------------------------------------"
nnoremap <leader>ut :Unite tag -input=
nnoremap <leader>uu :Unite<CR>
let g:unite_source_tag_max_fname_length=80

"------------------------------------------------------------------------------"
"----------------------------- Useful Things ----------------------------------"
"------------------------------------------------------------------------------"
" Global search and replace :
"     :args `grep -Rl txtToSearch`
"     :argdo %s/txtToSearch/txtToReplace/ge | update
