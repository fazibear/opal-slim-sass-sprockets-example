# use sprockets directive to include jquery
#= require 'jquery'

require 'opal'
require 'opal-jquery'

Document.ready? do
  # checkout browser console
  puts "Message from opal"

  # add some text to h2
  Element.find('#element').text = "Setting header with Opal"

  # onclick event
  Element.find('#button').on :click do
    Element.find('#element').text = "Button Clicked!"
  end
end
