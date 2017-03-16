require_relative "../transpiler.rb"
require "test/unit"
require_relative "sampleSnippets.rb"

class TranspilerTest < Test::Unit::TestCase
  (@@languages_supported).each do |origin_language|
    (@@languages_supported - [origin_language]).each do |destiny_language|
      @@snippets.each do |scenario, code|
        define_method("test_transpiling_from_#{origin_language}_to_#{destiny_language}_on_#{scenario}") do

          expected_snippet = code[destiny_language]
          snippet_transpiled = transpile(code: code[origin_language], from: origin_language, to: destiny_language)

          one_line_expected = (expected_snippet.strip).scan(/[^\s]+/).join(" ")
          resultant_line_expected = (snippet_transpiled.strip).scan(/[^\s]+/).join(" ")

          assert_equal(one_line_expected, resultant_line_expected)
        end
      end
    end
  end
end