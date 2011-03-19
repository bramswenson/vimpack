require 'spec_helper'

describe Vimpack::Models::Script do

  context "the class" do
    %w( search get info ).each do |meth|
      it "should respond to #{meth}" do
        Vimpack::Models::Script.should respond_to(meth.to_sym)
      end
    end
  end

  context "an instance" do
    
    context "should respond to" do
      let(:script) { Vimpack::Models::Script.new }
      %w( name script_type summary repo_url script_version description
          author install! uninstall! installed? installable? ).each do |meth|
        it meth do
          script.should respond_to(meth.to_sym)
        end
      end
    end

    context "that exists in vimpack.org" do

      let(:script) { Vimpack::Models::Script.get('rails.vim') }
      let(:repo)   { Vimpack::Models::Repo }
      script_data = {
        :name => "rails.vim",
        :script_type => "utility",
        :summary => "Ruby on Rails: easy file navigation, enhanced syntax highlighting, and more",
        :repo_url => "http://github.com/vim-scripts/rails.vim.git",
        :script_version => "4.3",
      }
      script_data.each_pair do |attribute, value|

        it "should have a #{attribute} of #{value}" do
          script.send(attribute).should == value 
        end
        
      end

      context "installable?" do

        it "should be false if vimpack is not initialized" do
          script.should_not be_installable 
        end

        it "should be true if vimpack is initialized" do
          repo.initialize_repo!
          script.should be_installable
        end

      end

      context "installed?" do

        before(:each) { repo.initialize_repo! }

        it "should be false if script is not installed" do
          script.should_not be_installed
        end

        it "should be true if script is installed" do
          script.install!
          script.should be_installed
        end

      end

      context "install!" do

        context "when vimpack is not initialized" do
          it "should raise an error" do
            expect { script.install! }.to raise_error
          end
        end

        context "when vimpack is initialized" do
          before(:each) { repo.initialize_repo! }

          it "should return true when script installed without errors" do
            script.install!.should be_true
          end

          it "should raise an error if script is already installed" do
            script.install!
            expect { script.install! }.to raise_error
          end

        end
      end

      context "uninstall!" do

        context "when vimpack is not initialized" do
          it "should raise an error" do
            expect { script.uninstall! }.to raise_error
          end
        end

        context "when vimpack is initialized" do
          before(:each) { repo.initialize_repo! }

          it "should return true when script uninstalled without errors" do
            script.install!
            script.uninstall!.should be_true
          end

          it "should raise an error if script is already uninstalled" do
            expect { script.uninstall! }.to raise_error
          end

        end
      end
    end
  end
end
