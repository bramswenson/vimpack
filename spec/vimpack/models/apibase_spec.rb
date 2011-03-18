require 'spec_helper'

describe Vimpack::Models::ApiBase do

  context "the class" do
    %w( from_json base_url ).each do |meth|
      it "should respond to #{meth}" do
        Vimpack::Models::ApiBase.should respond_to(meth.to_sym)
      end
    end

    it "should have a default base url of http://api.vimpack.org/api/v1" do
      Vimpack::Models::ApiBase.base_url.should == 'http://api.vimpack.org/api/v1'
    end
  end
end
