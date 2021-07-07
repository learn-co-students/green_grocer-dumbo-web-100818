require 'pry'

def consolidate_cart(cart)
	consolidated = {}
	cart.each do |item|
		item_name = item.keys().first()
		if consolidated.has_key?(item_name)
			consolidated[item_name][:count] += 1
		else
			consolidated[item_name] = item[item_name]
			consolidated[item_name][:count] = 1
		end
	end
	return consolidated
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon_item = coupon[:item]
    if cart.has_key?(coupon_item)
      cart_item = cart[coupon_item]
      if cart.has_key?("#{coupon_item} W/COUPON") && cart_item[:count] >= coupon[:num]
				cart_item[:count] -= coupon[:num]
        cart["#{coupon_item} W/COUPON"][:count] += 1
      elsif cart_item[:count] >= coupon[:num]
				cart_item[:count] -= coupon[:num]
        cart["#{coupon_item} W/COUPON"] = {price: coupon[:cost], clearance: cart_item[:clearance], count: 1}
      end
    end
  end
  return cart
end

def apply_clearance(cart)
	cart.each {|item, details| details[:price] = (details[:price] *0.8).round(2) if details[:clearance] }
  return cart
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated, coupons)
  clearance_applied = apply_clearance(coupons_applied)

  total = 0
  clearance_applied.each {|item, details| total += details[:price] * details[:count]}

	total > 100 ? apply_10_percent(total) : total
end

def apply_10_percent(total)
	return total * 0.9.round(2)
end
