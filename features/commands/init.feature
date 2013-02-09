Feature: Initialize vimpack

  As a vimpack user
  I want to initialize vimpack
  So I can have a sane way to manage vim scripts

  Scenario: Initialize vimpack in an existing vim environment
    Given a directory named ".vim"
      And an empty file named ".vimrc"
      And "./" is my home directory
    When I successfully run `vimpack init --trace`
    Then a directory named ".vim.before_vimpack" should exist
      And a file named ".vimrc.before_vimpack" should exist
      And the output should contain " * initializing vimpack repo"
      And a directory named ".vimpack" should exist and be a git repo
      And a directory named ".vimpack/vim" should exist
      And a directory named ".vimpack/vim/autoload" should exist
      And a directory named ".vimpack/vim/bundle" should exist
      And a directory named ".vimpack/scripts" should exist
      And a symlink named ".vim" should exist and link to ".vimpack/vim"
      And a directory named ".vimpack/scripts/utility/pathogen.vim" should exist and be a git submodule of ".vimpack"
      And a symlink named ".vimpack/vim/autoload/pathogen.vim" should exist and link to ".vimpack/scripts/utility/pathogen.vim/plugin/pathogen.vim"
      And a symlink named ".vimrc" should exist and link to ".vimpack/vimrc"
      And the output should contain "vimpack initialized!"
      And the exit status should be 0

  Scenario: Initialize vimpack from git repo
    Given a directory named ".vim"
      And an empty file named ".vimrc"
      And "./" is my home directory
    When I run `vimpack init git@github.com:bramswenson/vimpack-repo-test.git`
    Then a directory named ".vim.before_vimpack" should exist
      And a file named ".vimrc.before_vimpack" should exist
      And the output should contain " * initializing vimpack repo from git@github.com:bramswenson/vimpack-repo-test.git"
      And a directory named ".vimpack" should exist and be a git repo
      And a directory named ".vimpack/vim" should exist
      And a directory named ".vimpack/vim/autoload" should exist
      And a directory named ".vimpack/vim/bundle" should exist
      And a directory named ".vimpack/scripts" should exist
      And a symlink named ".vim" should exist and link to ".vimpack/vim"
      And a directory named ".vimpack/scripts/utility/pathogen.vim" should exist and be a git submodule of ".vimpack"
      And a symlink named ".vimpack/vim/autoload/pathogen.vim" should exist and link to ".vimpack/scripts/utility/pathogen.vim/plugin/pathogen.vim"
      And a symlink named ".vimrc" should exist and link to ".vimpack/vimrc"
      And the output should contain "vimpack initialized!"
      And the vimpack git remote "origin" should be "git@github.com:bramswenson/vimpack-repo-test.git"
      And the exit status should be 0

