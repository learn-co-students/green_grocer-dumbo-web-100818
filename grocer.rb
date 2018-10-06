require "pry"
def consolidate_cart(cart)
  new_hash = Hash.new{|hsh,key| hsh[key] = {:count => 0}}
  
  
  cart.collect do |hash_chunk|
    hash_chunk.collect do |vegetable, price_stuff|
      price_stuff.collect do |k, v|
        
      new_hash[vegetable].store(k, v)
     

    end
    new_hash[vegetable][:count] += 1
    end
  end
  new_hash
end


 
def apply_coupons(cart, coupons)
  new_hash = Hash.new{|hsh, key| hsh[key] = {:count => 0} }
  
  if !(coupons.empty?)
  coupons.each do |hash_chunk|
   hash_chunk.each do |k,v|
      
  cart.each do |vegetable, chunk|
    if v.to_s == vegetable.to_s
     if cart[vegetable][:count] < hash_chunk[:num]
         new_hash[vegetable].store(:price, cart[vegetable][:price]) 
       new_hash[vegetable].store(:clearance, cart[vegetable][:clearance]) 
       new_hash[vegetable].store(:count, cart[vegetable][:count])
     else
       new_hash[vegetable].store(:price, cart[vegetable][:price]) 
       new_hash[vegetable].store(:clearance, cart[vegetable][:clearance]) 
       new_hash[vegetable].store(:count, cart[vegetable][:count] -= hash_chunk[:num])
      
      new_hash["#{vegetable} W/COUPON"].store(:price, hash_chunk[:cost])
      new_hash["#{vegetable} W/COUPON"].store(:clearance, cart[vegetable][:clearance])
      new_hash["#{vegetable} W/COUPON"].store(:count, new_hash["#{vegetable} W/COUPON"][:count] += 1)
    end
    else
       new_hash[vegetable].store(:price, cart[vegetable][:price]) 
       new_hash[vegetable].store(:clearance, cart[vegetable][:clearance]) 
       new_hash[vegetable].store(:count, cart[vegetable][:count])
     end
      end
    end
  end
new_hash
else 
cart
end
end

def apply_clearance(cart)
  cart.each do |food_name, data|
    data.each do |k, v|
      if v == true
  cart[food_name][:price] =  cart[food_name][:price] -= (0.2 * cart[food_name][:price])
end
end
end
cart
  end

def checkout(cart, coupons)
  #fixed_cart = consolidate_cart(cart)
  #coupon_cart = apply_coupons(fixed_cart, coupons)
  #clearance_cart = apply_clearance(coupon_cart)
  
  the_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  
  cart_total = 0
  
  the_cart.each do |food_name, data|
    #data.each do |k, v|
      cart_total += (the_cart[food_name][:price] * the_cart[food_name][:count])
         
 
end
 if cart_total > 100 
   cart_total = cart_total -(cart_total* 0.1)
 end
 cart_total
end