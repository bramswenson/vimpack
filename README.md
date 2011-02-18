# vimpack

vim package manager

### setup vimpack

    # for now we install from the repo
    $ git clone git@github.com:bramswenson/vimpack.git
    $ cd vimpack
    $ bundle install
    $ rake build
    $ gem install pkg/vimpack-0.0.1.gem
    $ rake cucumber (if you want to run the tests)

    $ vimpack init
     * backing up existing vim environment
     * initializing vimpack repo
     * installing pathogen.vim
     * initializing .vimrc
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
     * installing rails.vim
    rails.vim (4.3) installed!

    $ vimpack list
    rails.vim

    $ vimpack uninstall rails.vim
     * uninstalling rails.vim
    rails.vim uninstalled!

