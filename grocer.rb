require 'pry'
 def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item_hash|
    item_hash.each do |item, info|
       if !new_cart[item]
         new_cart[item] = info
         new_cart[item][:count] = 1
       else
         new_cart[item][:count] += 1 
       end
    end
  end
  new_cart
end

 # [
 #     {:item => "AVOCADO", :num => 2, :cost => 5.00},
 #     {:item => "BEER", :num => 2, :cost => 20.00},
  #    {:item => "CHEESE", :num => 3, :cost => 15.00}
  #  ]


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num] # cart[name] is a 'truthy' value, basically asking if it exists
      if cart["#{name} W/COUPON"]                     # <-- initially tried this while looping over the cart which isn't possible
        cart["#{name} W/COUPON"][:count] += 1         # checking the double if statements and editing the original cart rules out any 
      else                                             #  need for describing original items
        
      cart["#{name} W/COUPON"] = {
        :count => 1,
        :price => coupon[:cost],
        :clearance => cart[name][:clearance]
      }
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end



def apply_clearance(cart)
 cart.each do |item, item_hash|
    item_hash.each do |key, value|
        if cart[item][:clearance] == true && key == :price
           cart[item][:price] = value - (value * 0.20)
        else
           next
        end
    end
  end
  cart
end


def checkout(cart , coupons )
     cart = consolidate_cart(cart) #sets cart equal to the result of consolidate_cart
     cart = apply_coupons(cart, coupons) #sets cart equal to result of consolidate_cart + apply_coupons
     cart = apply_clearance(cart) # sets cart equal to result of consolidate_cart + apply_coupons + apply_clearance
    
  total = 0  # have to set a reference, otherwise nil (like the accumulator in .inject)
  cart.each do |item, item_hash|
   total += item_hash[:price] * item_hash[:count] # easier to iterate over the cart to
  end                                             # get the prices than to create an array of price
     if total > 100
       total * 0.90
     else
     total
     end
  end


