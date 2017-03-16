require 'yaml'
require 'pp'

def transpile(code: "", from: "", to: "") 
  
  origin = YAML.load_file("#{File.dirname(__FILE__)}/descriptors/#{from}.yml")
  destiny = YAML.load_file("#{File.dirname(__FILE__)}/descriptors/#{to}.yml")
  
  parse_code(code, origin, destiny)
end

def parse_code(code_block, origin_languague_parser, final_languague_parser)

  origin_languague_parser.each do |key, expression|   
    
    pattern = expression["pattern"]
    final_structure = final_languague_parser[key]["format"]


    #puts "TRYING WITH #{key}"

    code_block.scan(pattern) do |sentence|
      sentence_structure = final_structure
      match = (sentence.join).match(pattern)

      #puts "code #{sentence.join} \n under match #{match.captures rescue ""} \n for #{pattern} \n as #{key}"

      if match != nil
        captures = Hash[match.names.zip( match.captures)]

        #puts "String: #{sentence.join} MATCH: #{match.captures} : Pattern: #{pattern}"

        sentence_structure.scan(/\{\{(.*?)\}\}/m).flatten.each do |tag|
          if (final_languague_parser[key][tag] != nil)
            replace  = parse_code(captures[tag], origin_languague_parser[key][tag], final_languague_parser[key][tag])
            sentence_structure=sentence_structure.gsub("{{#{tag}}}", replace) #puts "We are gonna replace {{#{tag}}} in #{sentence_structure} with #{replace}"
          else
            #puts "We are gonna replace {{#{tag}}} in #{sentence_structure} with #{captures[tag]}"
            sentence_structure=sentence_structure.gsub("{{#{tag}}}", captures[tag])
          end
        end
        code_block = code_block.gsub(sentence.join, sentence_structure)
      else

      end
    end  
    
  end

  return code_block
end


#match = code.match(pattern)
#captures = Hash[ match.names.zip( match.captures ) ] 
#p "String: #{i.join} MATCH: #{match} : Pattern: #{pattern}" 
 

  