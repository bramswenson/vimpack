require 'spec_helper'
require 'pathname'

describe Vimpack::Models::Repo do

  let :vimpack, do Vimpack::Models::Repo end

  %w( home_path initialize_repo! initialized? ).each do |meth|
    it "should respond to #{meth}" do
      vimpack.should respond_to(meth.to_sym)
    end
  end

  it "should have home path set to #{HOME}" do
    vimpack.home_path.to_s.should == HOME
  end

  context "initialized?" do

    it "should be false when no ~/.vimpack directory exists" do
      vimpack.should_not be_initialized
    end

    it "should be true when no ~/.vimpack directory exists" do
      ::FileUtils.mkdir_p(vimpack.pack_path.to_s)
      ::File.should be_a_directory(::File.join(HOME, '.vimpack'))
      vimpack.should be_initialized
    end
  end

  context "initialize_repo!" do

    context "when already initialized" do

      it "should raise error" do
        ::FileUtils.mkdir_p(vimpack.pack_path.to_s)
        ::File.should be_a_directory(::File.join(HOME, '.vimpack'))
        expect { vimpack.initialize_repo! }.to raise_error(Vimpack::Models::Repo::AlreadyInitialized)
      end

    end

    context "when not initialized" do

      [ nil, 'git@github.com:bramswenson/vimpack-repo-test.git' ].each do |repo_url_arg|

        context "and given #{repo_url_arg} as the repo_url argument" do

          before(:each) do
            FileUtils.mkdir_p(vimpack.home_path.join('.vim'))
            File.new(vimpack.home_path.join('.vimrc'), 'w').close
            vimpack.initialize_repo!(repo_url_arg)
          end

          it "should backup existing vim files" do
            File.should exist(vimpack.home_path.join('.vim.before_vimpack'))
            File.should exist(vimpack.home_path.join('.vimrc.before_vimpack'))
          end

          %w( .vimpack .vimpack/vim .vimpack/vim/autoload .vimpack/vim/bundle
              .vimpack/scripts
          ).each do |dir_path|
            it "should have created a #{dir_path} directory in the home directory" do
              File.should be_a_directory(::File.join(HOME, dir_path))
            end
          end

          it "should be a git repository" do
            check_git_repo(vimpack.pack_path)
          end

          it "should have pathogen installed into autoload/bundle" do
            check_git_submodule(vimpack.vim_path.join('autoload', 'pathogen.vim'), vimpack.pack_path)
          end

          it "should have created a link .vim to .vimpack/vim" do
            File.should be_a_directory(vimpack.vim_path.to_s)
            File.should exist(vimpack.home_path.join('.vim'))
            Pathname.new(vimpack.home_path.join('.vim')).realpath.to_s.should == vimpack.vim_path.to_s
          end

          it "should have created a link .vimrc to .vimpack/vimrc" do
            File.should exist(vimpack.pack_path.join('vimrc'))
            File.should exist(vimpack.home_path.join('.vimrc'))
            Pathname.new(vimpack.home_path.join('.vimrc')).realpath.to_s.should == vimpack.pack_path.join('vimrc')
          end

          unless repo_url_arg.nil?

            it "should have a remote origin of git@github.com:bramswenson/vimpack-repo-test.git" do
              check_vimpack_remote('origin', 'git@github.com:bramswenson/vimpack-repo-test.git')
            end
          end
        end
      end
    end
  end
end
