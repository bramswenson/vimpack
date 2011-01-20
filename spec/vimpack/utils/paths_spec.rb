require 'spec_helper'
require 'tmpdir'

describe Vimpack::Utils::Paths do

  before(:each) do
    class TestUtils
      include Vimpack::Utils::Paths
    end
    @utils = TestUtils.new
  end

  context ".home_dir" do
    
    it "should return the value of the env HOME" do
      @utils.home_dir.should == ENV['HOME']
    end

    it "should return the value already set" do
      @utils.home_dir = 'tmp'
      @utils.home_dir.should_not == ENV['HOME']
    end

  end

  context ".vimrc_file" do
    
    before(:each) do
      @utils.home_dir = Dir.mktmpdir
      @vimrc_file_path = File.join(@utils.home_dir, '.vimrc')
    end

    it "should return the vimrc_file path" do
      @utils.vimrc_file.should == @vimrc_file_path
    end
    
    it "should return false when $HOME/.vimrc_file not a file" do
      @utils.vimrc_file_exists?.should be_false
    end

    it "should return true when $HOME/.vimrc_file is a file" do
      f = File.open(@vimrc_file_path, 'w')
      f.write('')
      f.close
      @utils.vimrc_file_exists?.should be_true
    end
  end

  context ".vimpack_dir" do
    
    before(:each) do
      @utils.home_dir = Dir.mktmpdir
      @vimpack_dir_path = File.join(@utils.home_dir, '.vimpack')
    end

    it "should return the vimpack_dir path" do
      @utils.vimpack_dir.should == @vimpack_dir_path
    end
    
    it "should return false when $HOME/.vimpack is not a directory" do
      @utils.vimpack_dir_exists?.should be_false
    end

    it "should return true when $HOME/.vimpack is a directory" do
      Dir.mkdir(@vimpack_dir_path)
      @utils.vimpack_dir_exists?.should be_true
    end

  end

  context ".vim_dir" do
    
    before(:each) do
      @utils.home_dir = Dir.mktmpdir
      @vim_dir_path = File.join(@utils.home_dir, '.vim')
    end

    it "should return the vim_dir path" do
      @utils.vim_dir.should == @vim_dir_path
    end
    
    it "should return false when $HOME/.vim is not a directory" do
      @utils.vim_dir_exists?.should be_false
    end

    it "should return true when $HOME/.vim is a directory" do
      Dir.mkdir(@vim_dir_path)
      @utils.vim_dir_exists?.should be_true
    end

  end

end
