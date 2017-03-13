require_relative "../transpiler.rb"
require "test/unit"
require_relative "codeSamples.rb"

class TranspilerTest < Test::Unit::TestCase
  
  (@@languages_supported).each do |f|
    (@@languages_supported - [f]).each do |t|
      @@samples.each do |scenario, codes|
        define_method("test_transpiling_from_#{f}_to_#{t}_on_#{scenario}") do 
          assert_equal(codes[t], transpile(code: codes[f], from: f, to: t))
        end
      end
    end
  end
  
end