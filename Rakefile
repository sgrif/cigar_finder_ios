# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require
require 'bubble-wrap/core'
require 'bubble-wrap/location'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Cigar Finder'

  app.frameworks += %w(CoreLocation MapKit QuartzCore)

  app.pods do
    pod 'NSDate-TimeDifference', '~> 1.0.1'
    pod 'MLPAutoCompleteTextField', '~> 1.3'
  end

  app.info_plist['UIBackgroundModes'] = %w(location)

  app.provisioning_profile = '/Users/sean/Library/MobileDevice/Provisioning Profiles/5B24C72B-6B0E-4A1E-B024-19FACE57B4F8.mobileprovision'

  app.testflight.sdk = 'vendor/TestFlight'
  app.testflight.api_token = '2f1a38248336d55aa445156b24aabec5_MTAxNTAwNTIwMTMtMDQtMjYgMTQ6MTU6MzIuNDc2MDEx'
  app.testflight.team_token = '5d42a39b132c99381195fae586ac51f9_MjE2ODg2MjAxMy0wNC0yNiAxOTo0NToyOS41Mjg3NTE'
end
