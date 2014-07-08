# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Myapp::Application.initialize!

config.assets.precompile += %w( jquery.tools.min.js )