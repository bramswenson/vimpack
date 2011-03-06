require 'spec_helper'

describe Vimpack::Models::Script do

  context "the class" do
    %w( search get info ).each do |meth|
      it "should respond to #{meth}" do
        Vimpack::Models::Script.should respond_to(meth.to_sym)
      end
    end
  end

  context "the instance" do
    let(:script) { Vimpack::Models::Script.new }
    %w( name script_type summary repo_url script_version description
        author install! uninstall! installed? ).each do |meth|
      it "should respond to #{meth}" do
        script.should respond_to(meth.to_sym)
      end
    end
  end

end
