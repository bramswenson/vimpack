require 'spec_helper'
require 'tmpdir'

describe Vimpack::Utils do

  before(:each) do
    class TestUtils
      include Vimpack::Utils
    end
    @utils = TestUtils.new
  end

  context ".homedir" do
    
    it "should return the value of the env HOME" do
      @utils.homedir.should == ENV['HOME']
    end

    it "should return the value already set" do
      @utils.homedir = 'tmp'
      @utils.homedir.should_not == ENV['HOME']
    end

  end

  context ".dotvim_exists?" do

    before(:each) do
      @utils.homedir = Dir.mktmpdir
      @dotvim_path = File.join(@utils.homedir, '.vim')
    end
    
    it "should return false when $HOME/.vim is not a directory" do
      @utils.dotvim_exists?.should be_false
    end

    it "should return true when $HOME/.vim is a directory" do
      Dir.mkdir(@dotvim_path)
      @utils.dotvim_exists?.should be_true
    end

  end

end
