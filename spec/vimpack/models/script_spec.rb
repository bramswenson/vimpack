require 'spec_helper'

describe Vimpack::Models::Script do
  let(:script_model) { Vimpack::Models::Script }

  context "the class" do
    %w( search get info ).each do |meth|
      it "should respond to #{meth}" do
        script_model.should respond_to(meth.to_sym)
      end
    end

    context "search" do
      
      context "by exact name" do

        it "should return a 1 item collection" do
          script_model.search('cucumber.zip').count.should == 1
        end

        it "should return a Script as the first result in the collection" do
          script_model.search('cucumber.zip').first.should be_a(script_model)
        end

      end

      context "by name that returns more than one result" do

        it "should return a more than 1 item collection" do
          script_model.search('rails').count.should > 1
        end

        it "should return a collection of Script instances" do
          script_model.search('rails').each do |script|
            script.should be_a(script_model)
          end
        end

      end
      context "by name that does not exist" do

        it "should return an empty collection" do
          script_model.search('boogity_boogity_boo').count.should == 0
        end

      end
    end

    context "info" do

      it "should raise an error when the script does not exist" do
        expect { script_model.info('boogity_boo_hoo') }.to raise_error
      end

      it "should return script when found" do
        script_model.info('rails.vim').should be_a(script_model)
      end

    end
    context "get" do

      it "should raise an error when the script does not exist" do
        expect { script_model.get('boogity_boo_hoo') }.to raise_error
      end

      it "should return script when found" do
        script_model.get('rails.vim').should be_a(script_model)
      end

    end
  end

  context "an instance" do
    
    context "should respond to" do
      let(:script) { script_model.new }
      %w( name script_type summary repo_url script_version description
          author install! uninstall! installed? installable? ).each do |meth|
        it meth do
          script.should respond_to(meth.to_sym)
        end
      end
    end

    context "that exists in vimpack.org" do

      let(:script) { script_model.get('rails.vim') }
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
