
desc "Build a new gemspec"
task :gemspec do
  rejects = [
    '.autotest',
    '.bundle',
    '.gitignore',
    '.rbenv-version',
    '.rspec',
    '.rvmrc',
  ]
  files = `git ls-files`.split("\n").reject do |file|
    rejects.detect do |reject|
      file.end_with?(reject) || file.match(/#{reject}/)
    end
  end
  test_files  = `git ls-files -- {spec,features}/*`.split("\n")
  executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  gemspec_erb = File.read(File.expand_path('../../vimpack.gemspec.erb', __FILE__))
  gemspec_path = File.expand_path('../../vimpack.gemspec', __FILE__)
  gemspec_content = ERB.new(gemspec_erb).result(binding)
  File.open(gemspec_path, 'w') do |gemspec|
    gemspec.write(gemspec_content)
  end
end
