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

source_maps_prefix =  '/__OPAL_SOURCE_MAPS__'
source_maps = Opal::SourceMapServer.new(sprockets, source_maps_prefix)
::Opal::Sprockets::SourceMapHeaderPatch.inject!(source_maps_prefix)

#Opal::Processor.load_asset_code(sprockets, 'app')

map '/' do
  run sprockets
end

map source_maps_prefix do
  run source_maps
end
