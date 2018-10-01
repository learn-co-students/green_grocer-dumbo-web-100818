def consolidate_cart(cart)
  new_cart = {}
  cart.each do |element|
    element.each do |item, info|
      info.each do |k, v|
      if !new_cart.include?(item)
        new_cart[item] = {}
      end
      new_cart[item][k] = v
    end
    if new_cart[item][:count] == nil
      new_cart[item][:count] = 0
    end
    new_cart[item][:count] += 1
      end
    end
  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  cart.each do |element, info|
    new_cart[element] = info
    coupons.each do |coup|
      item_name = coup[:item]
      if element == item_name && info[:count] >= coup[:num]
        info[:count] = info[:count] - coup[:num]
        if new_cart.keys.include?(item_name + " W/COUPON")
          new_cart[item_name + " W/COUPON"][:count] += 1
          else
            new_cart[item_name + " W/COUPON"] = {:price => coup[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
  end
  return new_cart
end

def apply_clearance(cart)
  new_cart = {}
  cart.each do |element, info|
    if info[:clearance] == true
      new_cart[element] = {:price => (info[:price]*0.8).round(1), :clearance => info[:clearance], :count => info[:count] }
    else info[:clearance] == false
      new_cart[element] = {:price => info[:price], :clearance => info[:clearance], :count => info[:count] }
    end
  end
  new_cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total_cost = 0
  cart.each do |element, info|
    if cart[element][:count] > 0
    total_cost += ( cart[element][:price] * cart[element][:count] )
    if total_cost > 100
      total_cost = (total_cost * 0.9).round(1)
  end
end
end
total_cost
end
