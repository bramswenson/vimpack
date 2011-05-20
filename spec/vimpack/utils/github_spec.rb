require 'spec_helper'

describe Vimpack::Utils::Github do
  class GithubTest
    include Vimpack::Utils::Github
  end

  let(:github) { GithubTest }

  context ".search_all_repos" do

    it "should return a collection" do
      github.search_all_repos('rails').should respond_to(:[])
    end

    it "and the values should be github repo attributes" do
      github.search_all_repos('rails').count.should be >= 1
      github.search_all_repos('rails').each do |repo|
        repo.name.should_not be_nil
      end
    end

  end

  context ".search_vimscript_repos" do

    it "should return a collection" do
      github.search_vimscript_repos('rails').should respond_to(:[])
    end

    it "and the github repos username should be vim-scripts" do
      github.search_vimscript_repos('rails').count.should be >= 1
      github.search_vimscript_repos('rails').each do |repo|
        repo.username.should == 'vim-scripts'
      end
    end

  end
end
