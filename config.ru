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

  # add paths from opal
  Opal.paths.each do |p|
    s.append_path p
  end

  # add paths from rails-assets
  RailsAssets.load_paths.each do |p|
    s.append_path p
  end
end

Opal::Processor.source_map_enabled = false

puts Opal::Processor.load_asset_code(sprockets, 'app')

map '/' do
  run sprockets
end
