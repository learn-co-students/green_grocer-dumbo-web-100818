def consolidate_cart(cart)
	consolidate = {}

	cart.each do |item|
		item_name = item.keys().first()
		if consolidate.has_key?(item_name)
			consolidate[item_name][:count] += 1
		else
			consolidate[item_name] = item[item_name]
			consolidate[item_name][:count] = 1
		end
	end

	return consolidate
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon_item = coupon[:item]
    if cart.has_key?(coupon_item)
      cart_item = cart[coupon_item]
      cart_item[:count] -= coupon[:num]
      if cart.has_key?("#{coupon_item} W/COUPON")
        cart["#{coupon_item} W/COUPON"][:count] += 1
      else
        cart["#{coupon_item} W/COUPON"] = {price: coupon[:cost], clearance: cart_item[:clearance], count: 1}
      end
    end
  end
  return cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance]
      info[:price] = (info[:price] * 0.8).round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
  consolidate_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidate_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  total = 0
  clearance_cart.each {|item, info| total += info[:price]}
  return total
end
