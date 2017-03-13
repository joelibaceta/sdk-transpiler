require 'yaml'
require 'pp'

def transpile(code: "", from: "", to: "")
   
  
  origin = YAML.load_file("#{File.dirname(__FILE__)}/descriptors/#{from}.yml")
  destiny = YAML.load_file("#{File.dirname(__FILE__)}/descriptors/#{to}.yml")
  
  origin["expression_patterns"].each do |key, expression| 
    #p expression["pattern"]
    pattern = expression["pattern"]
    
    #match = code.match(pattern)
    #captures = Hash[ match.names.zip( match.captures ) ]  
    final_format = destiny["expression_patterns"][key]["format"]
    
    code.scan(pattern) do |i|
      match = (i.join).match(pattern) 
      _format = final_format
      captures = Hash[ match.names.zip( match.captures ) ] 
      _format.scan(/\{\{(.*?)\}\}/m).each do |variable|  
        _format=_format.gsub("{{#{variable[0]}}}", captures[variable[0]]) 
      end 
      code = code.gsub(i.join, _format)
    end  
  end   
  return code
end

  