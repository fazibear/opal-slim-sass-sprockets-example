require 'bundler'
Bundler.require

sprockets = Sprockets::Environment.new.tap do |s|

  # register slim
  s.register_engine '.slim', Slim::Template

  # register opal
  s.register_engine '.rb', Opal::Processor

  # add folders
  s.append_path 'app'
  s.append_path 'views'
  s.append_path 'styles'
  s.append_path 'vendor'

  # add path to opal gems
  Opal.paths.each do |p|
    s.append_path p
  end
end

Opal::Processor.source_map_enabled = false

map '/' do
  run sprockets
end
