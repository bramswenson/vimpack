# vimpack

vim package manager

## Initial Goals

### setup vimpack

    $ vimpack init
    * backing up existing vim configuration
    * creating vimpack repo
    * initializing pathogen submodule
    * cloning pathogen into repo
    * adding pathogen to pack
    * creating .vimrc
    * creating .vimpack
    * creating symlinks 
    vimpack initialized!

    $ vimpack search rails
    rails.vim                       utility    
    railscast                       colorscheme
    Railscast There (GUI&256color)  colorscheme
    railstab.vim                    utility    
    FastGrep                        utility
    apidock.vim                     utility
    grails-vim                      utility
    
    $ vimpack info rails.vim
    Name: rails.vim
    Author: Tim Pope
    Version: 4.3
    Description: Ruby on Rails: easy file navigation, enhanced syntax highlighting, and more

    $ vimpack install rails.vim
    * initializing rails.vim submodule
    * cloning rails.vim into repo
    * adding rails.vim to pack
    rails.vim 4.3 installed!

    $ vimpack list
    rails.vim 4.3

    $ vimpack uninstall rails.vim
    * deleting rails.vim submodule
    * deleting rails.vim from repo
    * removing rails.vim from pack
    rails.vim uninstalled!

