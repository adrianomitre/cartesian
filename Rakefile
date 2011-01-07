require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/cartesian'

Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'cartesian' do
  self.developer 'Adriano Mitre', 'adriano.mitre@gmail.com'
  self.post_install_message = 'PostInstall.txt' # TODO remove if post-install message not required
  self.rubyforge_name       = self.name # TODO this is default value
  # self.extra_deps         = [['activesupport','>= 2.0.2']]

end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# remove_task :default
# task :default => [:spec, :features]

task :chdir do
  Dir.chdir File.dirname(File.expand_path(__FILE__))
end

task :render_docs => [:chdir] do
  system %q{ rm -rf doc/ }
  system %q{ rdoc README.rdoc lib/*.rb }
end

task :render_website => [:chdir, :render_docs] do |t|
  system %q{ script/txt2html website/index.txt website/template.html.erb > website/index.html }
  system %q{ rm -rf website/doc; cp -R doc website }
end

task :pre_release => [:manifest, :render_website] do
  unless `git diff Manifest.txt`.empty?
    puts
    puts "  Manifest.txt was re-generated and there were changes."
    puts "  Use 'git diff Manifest.txt' to inspect them."
    puts
  end
end

