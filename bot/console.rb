require 'require_all'
require_all Dir.glob('./*/**/*.rb').reject { |f| f.include?('db') }

binding.pry