# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vimpack/version"

Gem::Specification.new do |s|
  s.name        = "vimpack"
  s.version     = Vimpack::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bram Swenson"]
  s.email       = ["bram@craniumisajar.com"]
  s.homepage    = ""
  s.summary     = %q{ Vim Script Package Manager }
  s.description = %q{ Vim Script Package Manager based on pathogen.vim by Tim Pope }

  s.rubyforge_project = "vimpack"

  s.files         = ["Gemfile", "LICENSE", "README.md", "Rakefile", "autotest/discover.rb", "bin/vimpack", "cucumber.yml", "features/commands/environments.feature", "features/commands/git.feature", "features/commands/info.feature", "features/commands/init.feature", "features/commands/install.feature", "features/commands/list.feature", "features/commands/search.feature", "features/commands/uninstall.feature", "features/step_definitions/environment_steps.rb", "features/step_definitions/file_utils_steps.rb", "features/step_definitions/initialize_steps.rb", "features/step_definitions/output_steps.rb", "features/step_definitions/vimpack_git_steps.rb", "features/support/env.rb", "features/support/executable_paths.rb", "lib/vimpack.rb", "lib/vimpack/commands.rb", "lib/vimpack/commands/command.rb", "lib/vimpack/commands/git.rb", "lib/vimpack/commands/info.rb", "lib/vimpack/commands/init.rb", "lib/vimpack/commands/install.rb", "lib/vimpack/commands/list.rb", "lib/vimpack/commands/search.rb", "lib/vimpack/commands/uninstall.rb", "lib/vimpack/models.rb", "lib/vimpack/models/apibase.rb", "lib/vimpack/models/base.rb", "lib/vimpack/models/repo.rb", "lib/vimpack/models/script.rb", "lib/vimpack/utils/api.rb", "lib/vimpack/utils/file.rb", "lib/vimpack/utils/file_path.rb", "lib/vimpack/utils/git.rb", "lib/vimpack/utils/github.rb", "lib/vimpack/utils/io.rb", "lib/vimpack/utils/process.rb", "lib/vimpack/utils/vimscripts.rb", "lib/vimpack/version.rb", "simplecov_setup.rb", "spec/spec_helper.rb", "spec/vimpack/models/repo_spec.rb", "spec/vimpack/models/script_spec.rb", "spec/vimpack/utils/github_spec.rb", "spec/vimpack/utils/vimscripts_spec.rb", "tasks/cucumber.rake", "tasks/default.rake", "tasks/gemspec.rake", "templates/vimrc.erb", "vimpack.gemspec", "vimpack.gemspec.erb"]
  s.test_files    = ["features/commands/environments.feature", "features/commands/git.feature", "features/commands/info.feature", "features/commands/init.feature", "features/commands/install.feature", "features/commands/list.feature", "features/commands/search.feature", "features/commands/uninstall.feature", "features/step_definitions/environment_steps.rb", "features/step_definitions/file_utils_steps.rb", "features/step_definitions/initialize_steps.rb", "features/step_definitions/output_steps.rb", "features/step_definitions/vimpack_git_steps.rb", "features/support/env.rb", "features/support/executable_paths.rb", "spec/spec_helper.rb", "spec/vimpack/models/repo_spec.rb", "spec/vimpack/models/script_spec.rb", "spec/vimpack/utils/github_spec.rb", "spec/vimpack/utils/vimscripts_spec.rb"]
  s.executables   = ["vimpack"]
  s.require_paths = ["lib"]

  s.add_dependency('commander', '~> 4.1.3')
  s.add_dependency('oj',        '~> 2.0.3')
  s.add_dependency('octokit',   '~> 1.23.0')

  #s.add_development_dependency('vcr')
  #s.add_development_dependency('webmock')
  #s.add_development_dependency('relish')
  s.add_development_dependency('cucumber')
  s.add_development_dependency('rspec')
  s.add_development_dependency('aruba')
  s.add_development_dependency('pry')
  s.add_development_dependency('debugger')
  s.add_development_dependency('guard')
  s.add_development_dependency('guard-rspec')
  s.add_development_dependency('guard-cucumber')
  s.add_development_dependency('rb-inotify', '~> 0.8.8')
end
