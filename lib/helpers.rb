def setup_shared_folders
  run "umask 02 && mkdir -p #{shared_path}/config"
end

def template(*args)
  expand_path_for('templates', args)
end

def expand_path_for(path)
  e = File.join(File.dirname(__FILE__), path)
  File.expand_path(e)
end

def parse_template(file)
  require 'erb'
  template = File.read(file)
  return ERB.new(template).result(binding)
end