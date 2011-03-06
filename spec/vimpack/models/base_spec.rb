require 'spec_helper'


describe Vimpack::Api::Models::Base do

  context "the class" do
    %w( json_parser from_json base_url ).each do |meth|
      it "should respond to #{meth}" do
        Vimpack::Api::Models::Base.should respond_to(meth.to_sym)
      end
    end

    it "should have a default base url of http://api.vimpack.org/api/v1" do
      Vimpack::Api::Models::Base.base_url.should == 'http://api.vimpack.org/api/v1'
    end
  end
end
