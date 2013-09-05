# See http://railsapps.github.io/tutorial-rails-devise-rspec-cucumber.html

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end
