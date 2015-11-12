# Add this project's lib to our LOAD_PATH
$LOAD_PATH << File.realpath(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec/collection_matchers'
require 'tictactoe'
