
guard 'rspec', :cli => "--color --format nested", :all_after_pass => false, :all_on_start => false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

guard 'cucumber', :cli => '--profile default', :all_after_pass => false, :all_on_start => false do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  #watch(%r{^bin/vimpack$}) { "features/commands/init.feature" }
end

