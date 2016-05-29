require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara/webkit'

Capybara.configure do |config|
  config.run_server = false
  config.app_host   = File.expand_path('../../../../lib/', __FILE__)
  config.default_driver = :webkit
  config.save_and_open_page_path = 'tmp/pages'
  config.ignore_hidden_elements = true
end

RSpec.configure do |config|
  config.include Capybara::DSL, type: :feature
end