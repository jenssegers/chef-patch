require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'rake/dsl_definition'

namespace :style do
  desc 'Run RuboCop style and lint checks'
  RuboCop::RakeTask.new(:rubocop)

  desc 'Run Foodcritic lint checks'
  FoodCritic::Rake::LintTask.new(:foodcritic) do |t|
    t.options = {
      tags: %w(~FC023 ),
      fail_tags: ['any'],
      # include_rules: '',
      context: true
    }
  end
end

desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color --format documentation'
end

desc 'Run all style checks'
task :style => ['style:rubocop', 'style:foodcritic', 'spec']

# Default
task :default => [:style]
