require 'spec_helper'

describe Vimpack::Utils::Vimscripts do
  class VimscriptsTest
    include Vimpack::Utils::Vimscripts
  end

  let(:vimscripts) { VimscriptsTest }

  context ".vimscripts" do

    it "should be a collection of script attribute hashes" do
      vimscripts.vimscripts.first["n"].should == 'test.vim'
    end
  end

  context ".search_vimscripts" do

    it "should return a collection of hash like objects" do
      vimscripts.search_vimscripts('rails').each do |script|
        script.should respond_to(:keys)
      end
    end

    it "all scripts returned should include the query in the name" do
      vimscripts.search_vimscripts('rails').each do |script|
        (script[:description].downcase.include?('rails') or
         script[:name].downcase.include?('rails')).should be_true
      end
    end

    it "should leave the vimscripts in place" do
      vimscripts.search_vimscripts('rails')
      vimscripts.vimscripts.count.should be_between(3000, 4000)
    end

  end
end
