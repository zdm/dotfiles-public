:: NOTE https://medium.com/@paulodiovani/installing-vim-8-plugins-with-the-native-pack-system-39b71c351fea

cd "%~dp0\..\..\.local\share\nvim\site\pack\plugins\start

git submodule add https://github.com/tomtom/tcomment_vim

git submodule add https://github.com/Shougo/unite.vim
git submodule add https://github.com/Shougo/neomru.vim
:: git submodule add https://github.com/easymotion/vim-easymotion
git submodule add https://github.com/Shougo/unite-outline
git submodule add https://github.com/mbbill/undotree
git submodule add https://github.com/powerman/vim-plugin-viewdoc
:: git submodule add https://github.com/nathanaelkane/vim-indent-guides.git
git submodule add https://github.com/mhinz/vim-signify
git submodule add https://github.com/Konfekt/FastFold
git submodule add https://github.com/Yggdroot/indentLine

:: airline
git submodule add https://github.com/vim-airline/vim-airline
git submodule add https://github.com/vim-airline/vim-airline-themes

:: xkbd
:: git submodule add https://github.com/lyokha/vim-xkbswitch", {"depends": "DeXP/xkb-switch-win"})
:: git submodule add https://github.com/DeXP/xkb-switch-win

:: perl
git submodule add https://github.com/zdm/vim-perl
:: git submodule add https://github.com/vim-perl/vim-perl

:: javascript
git submodule add https://github.com/zdm/vim-javascript
:: git submodule add https://github.com/pangloss/vim-javascript", {"autoload":{"filetypes":["javascript"]}})

:: C
git submodule add https://github.com/justinmk/vim-syntax-extra

:: other plugins
:: git submodule add https://github.com/arecarn/vim-crunch
git submodule add https://github.com/tpope/vim-fugitive
git submodule add https://github.com/chrisyip/Better-CSS-Syntax-for-Vim
:: git submodule add https://github.com/vim-scripts/autocorrect.vim
git submodule add https://github.com/uguu-org/vim-matrix-screensaver
git submodule add https://github.com/vim-scripts/forth.vim
git submodule add https://github.com/vim-scripts/DirDiff.vim
:: git submodule add https://github.com/chrisbra/NrrwRgn
git submodule add https://github.com/joelfrederico/vim-HiLinkTrace
git submodule add https://github.com/zhimsel/vim-stay

git submodule add https://github.com/pedrohdz/vim-yaml-folds

:: pgsql syntax
git submodule add https://github.com/lifepillar/pgsql.vim

git submodule add https://github.com/editorconfig/editorconfig-vim

:: markdown
git submodule add https://github.com/foalford/vim-markdown-folding

:: completion
git submodule add https://github.com/hrsh7th/nvim-compe
git submodule add https://github.com/hrsh7th/vim-vsnip
:: git submodule add https://github.com/rafamadriz/friendly-snippets

:: XXX disabled, because syntax/javascript.vim conflicted when used with dein
:: git submodule add https://github.com/mattn/emmet-vim

:: git submodule add https://github.com/vim-scripts/Marks-Browser
:: git submodule add https://github.com/w0rp/ale
:: git submodule add https://github.com/hexman.vim
:: git submodule add https://github.com/motemen/xslate-vim
:: call dein#add(highlight.vim
:: git submodule add https://github.com/tpope/vim-surround

:: update plugins
git submodule update --remote --merge

:: :helptags ~/.vim/pack/plugins/start/foo
:: :helptags ALL
