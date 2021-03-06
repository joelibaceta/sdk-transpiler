@@languages_supported=["php", "nodejs", "ruby"] #"python", "dotnet", "java"

@@snippets = Hash.new;

@@snippets["basic_integration"]=Hash.new

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

  ?>'
  
@@snippets["basic_integration"]["php"] = code

code = ' 
    preference = MercadoPago::Preference.new()
    
    item = MercadoPago::Item.new()
    item.title = "Multicolor kite"
    item.quantity = 1
    item.currency_id = "ARS"
    item.unit_price = "10.00"
    
    payer = MercadoPago::Payer.new()
    payer.email = "usuario@mail.com"
    
    preference.items = [item]
    preference.payer = payer
    
    preference.save()  '
    
@@snippets["basic_integration"]["ruby"] = code

code = ' 
    MercadoPago.Preference preference = new MercadoPago.Preference();
    
    MercadoPago.Item item = new MercadoPago.Item();
    item.title = "Multicolor kite";
    item.quantity = 1;
    item.currency_id = "ARS";
    item.unit_price = "10.00";
    
    MercadoPago.Payer payer = new MercadoPago.Payer();
    payer.email = "usuario@mail.com";
    
    preference.items = (new MercadoPago.Item[]{$item});
    preference.payer = payer;
    
    preference.save();  '

@@snippets["basic_integration"]["java"] = code

code = ' 
  exports.run = function (req, res) {

      var preference = {}; \\ Preference

      var item = {}; \\ Item
      item["title"] = "Multicolor kite";
      item["quantity"] = 1;
      item["currency_id"] = "ARS";
      item["unit_price"] = "10.00";

      var payer = {}; \\ Payer
      payer["email"] = "usuario@mail.com";

      preference["items"] = [item];
      preference["payer"] = payer;

      mercadopago.preference.save().then(function (data) {
	 	    //... Do Something
	   });

   };  '

@@snippets["basic_integration"]["nodejs"] = code
 

