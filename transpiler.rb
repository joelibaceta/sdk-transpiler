require 'yaml'
require 'pp'

def translate(code: "", from: "", to: "")
  origin = YAML.load_file("descriptors/#{from}.yml")
  destiny = YAML.load_file("descriptors/#{to}.yml")
  
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


def test()
  code = '
    <?php 
    
      $preference = new MercadoPago\Preference();
      
      $item = new MercadoPago\Item();
      $item->title = "Multicolor kite";
      $item->quantity = 1;
      $item->currency_id = "ARS";
      $item->unit_price = "10.00";
      
      $payer = new MercadoPago\Payer();
      $payer->email = "usuario@mail.com";
      
      $preference->items = array($item);
      $preference->payer = $payer;
      
      $preference->save();
      
    ?> '
      
  puts "To Ruby"
  puts translate(code: code, from: "php", to: "ruby")
  puts "To NodeJS"
  puts translate(code: code, from: "php", to: "nodejs")
  puts "To Java"
  puts translate(code: code, from: "php", to: "java")

  #translate(code: code, from: "php", to: "ruby")
  
end

 test()