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
          script_model.search('cucumber').count.should == 1
        end

        it "should return a Script as the first result in the collection" do
          script_model.search('cucumber').first.should be_a(script_model)
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
      let(:script) { script_model.get('rails.vim') }
      %w(
        name type version author author_email version version_date url description
        install! uninstall! installed? installable? install_path
      ).each do |meth|
        it meth do
          script.should respond_to(meth.to_sym)
        end
      end
    end

    context "that exists in vim-scripts.org" do

      let(:script) { script_model.get('rails.vim') }
      let(:repo)   { Vimpack::Models::Repo }

      it "script should not be nil" do
        script.should_not be_nil
      end

      { :name => "rails.vim",
        :type => "utility",
        :version => "4.4",
        :version_date => '2011-08-26T17:00:00-07:00',
        :author => "Tim Pope",
        :author_email => "vim.org@tpope.org",
        :url => "https://github.com/vim-scripts/rails.vim.git",
        :description => "Ruby on Rails: easy file navigation, enhanced syntax highlighting, and more",
      }.each_pair do |attribute, value|

        it "should have a #{attribute} of '#{value}'" do
          script.send(attribute).should == value
        end

      end

      context "installable?" do

        it "should be false if vimpack is not initialized" do
          script.should_not be_installable
        end

        it "should be true if vimpack is initialized" do
          repo.initialize!
          script.should be_installable
        end

      end

      context "bundle_path" do

        before(:each) { repo.initialize! }

        it "should have an bundle path when not installed" do
          script.bundle_path.should_not be_nil
        end

        it "should have an bundle path when installed" do
          script.install!
          script.bundle_path.should_not be_nil
        end

        it "should be a path in the bundle dir" do
          script.bundle_path.should include(Vimpack::Models::Repo.bundle_path.to_s)
        end

      end

      context "install_path" do

        before(:each) { repo.initialize! }

        it "should have an install path when not installed" do
          script.install_path.should_not be_nil
        end

        it "should have an install path when installed" do
          script.install!
          script.install_path.should_not be_nil
        end

        it "should be a path in the scripts dir" do
          script.install_path.should include(Vimpack::Models::Repo.script_path.to_s)
        end

        it "should be a path named after the type" do
          script.install_path.should match(/#{script.type}/)
        end

      end

      context "installed?" do

        before(:each) { repo.initialize! }

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
          before(:each) { repo.initialize! }

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
          before(:each) { repo.initialize! }

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
