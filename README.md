# Vimpack

A configuration manager and script installer for vim based on pathogen.vim by Tim Pope. Here are some of its most interesting features:

  * Manage ones entire ~/.vim and ~/.vimrc in a git repository, called a vimpack (`vimpack init`)
  * Publish ones vimpack to github for use by others, or oneself on other machines (`vimpack git publish -m 'vimpack updated'`)
  * Clone ones entire vimpack to any other machine via github (`vimpack init <vimpack_repo_url>`)
  * Search for vim scripts from vim-scripts.org (`vimpack search <keyword>`)
  * Install vim scripts from vim-scripts.org (`vimpack install <script_name>`)
  * Uninstall vim scripts from vim-scripts.org (`vimpack uninstall <script_name>`)

There is more that vimpack can do, just checkout the documentation:

[Vimpack Documentation](http://relishapp.com/bramswenson/vimpack)
