require 'spec_helper'
require 'pathname'

describe Vimpack::Models::Repo do

  let :vimpack, do Vimpack::Models::Repo end

  %w( initialize! initialized? publish! git_exec installed_script_names
      installed_scripts ).each do |meth|
    it "should respond to #{meth}" do
      vimpack.should respond_to(meth.to_sym)
    end
  end

  it "should have home path set to #{HOME}" do
    vimpack.home_path.to_s.should == HOME
  end

  context "installed_script_names" do

    it "should return a collection of script names" do
      vimpack.initialize!
      Vimpack::Models::Script.get('rails.vim').install!
      vimpack.installed_script_names.should == ['rails.vim']
    end

  end

  context "installed_scripts" do

    it "should return a collection of scripts" do
      vimpack.initialize!
      rails_vim_script = Vimpack::Models::Script.info('rails.vim')
      rails_vim_script.install!
      vimpack.installed_scripts.count.should == 1
      vimpack.installed_scripts.each do |script|
        script.should be_a(Vimpack::Models::Script)
      end
    end

  end

  context "publish!" do

    it "should raise error with no origin remote set" do
      vimpack.initialize!
      expect { vimpack.publish!("[TEST] test from rspec") }.to raise_error(Vimpack::Models::Repo::OriginRemoteUnset)
    end

    it "should return true" do
      vimpack.initialize!('git@github.com:bramswenson/vimpack-repo-test.git')
      script_names = %w( rails.vim )
      script_names.each do |script_name|
        script = Vimpack::Models::Script.get(script_name)
        if script.installed?
          script.uninstall!
          vimpack.publish!("[uninstall] uninstalled #{script.name}")
        end
        script.install!
      end
      vimpack.publish!("[TEST] test from rspec").should be_true
      script_names.each do |script_name|
        Vimpack::Models::Script.get(script_name).uninstall!
      end
      vimpack.publish!("[TEST] cleanup testing").should be_true
    end
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

  context "initialize!" do

    context "when already initialized" do

      it "should raise error" do
        ::FileUtils.mkdir_p(vimpack.pack_path.to_s)
        ::File.should be_a_directory(::File.join(HOME, '.vimpack'))
        expect { vimpack.initialize! }.to raise_error(Vimpack::Models::Repo::AlreadyInitialized)
      end

    end

    context "when not initialized" do

      [ nil, 'git@github.com:bramswenson/vimpack-repo-test.git' ].each do |repo_url_arg|

        context "and given #{repo_url_arg} as the repo_url argument" do

          before(:each) do
            FileUtils.mkdir_p(vimpack.home_path.join('.vim'))
            File.new(vimpack.home_path.join('.vimrc'), 'w').close
            vimpack.initialize!(repo_url_arg)
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
            Pathname.new(vimpack.home_path.join('.vim')).realpath.to_s.gsub('/private', '').should == vimpack.vim_path.to_s
          end

          it "should have created a link .vimrc to .vimpack/vimrc" do
            File.should exist(vimpack.pack_path.join('vimrc'))
            File.should exist(vimpack.home_path.join('.vimrc'))
            Pathname.new(vimpack.home_path.join('.vimrc')).realpath.to_s.gsub('/private', '').should == vimpack.pack_path.join('vimrc')
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
