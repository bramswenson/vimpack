require 'spec_helper'

describe Vimpack::Models::Repo do

  let :vimpack, do Vimpack::Models::Repo end

  %w( home_path initialize_repo! ).each do |meth|
    it "should respond to #{meth}" do
      vimpack.should respond_to(meth.to_sym)
    end
  end

  it "should have home path set to #{HOME}" do
    vimpack.home_path.to_s.should == HOME
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

      before(:each) do
        FileUtils.mkdir_p(vimpack.home_path.join('.vim'))
        File.new(vimpack.home_path.join('.vimrc'), 'w').close
        vimpack.initialize_repo!
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
    end

  end
end
