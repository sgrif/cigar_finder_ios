# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require
require 'bubble-wrap/location'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Cigar Finder'

  app.frameworks += %w(CoreLocation MapKit)

  app.pods do
    pod 'NSDate-TimeDifference', '~> 1.0.1'
    pod 'MLPAutoCompleteTextField', '~> 1.3'
  end
end
