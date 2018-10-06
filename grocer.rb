require 'pry'
def consolidate_cart(cart)
	consolidated_cart = {}
	cart.each do |food_items|
		food_items.each do |food_item, atrributes|
			consolidated_cart[food_item] = atrributes if !consolidated_cart[food_item]
			consolidated_cart[food_item][:count] = 0 if !consolidated_cart[food_item][:count]
			consolidated_cart[food_item][:count] += 1
		end
	end
consolidated_cart
end

def apply_coupons(cart, coupons)
	coupons.each do |coupon|
		name = coupon[:item]
		if cart[name] && cart[name][:count] > coupon[:num]
			if cart["#{name} W/COUPON"]
				cart["#{name} W/COUPON"][:count] += 1
			else
				cart["#{name} W/COUPON"] = {price: coupon[:cost], count: 1}
				cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
			end
			cart[name][:count] -= coupon[:num]
		elsif cart[name] && cart[name][:count] == coupon[:num]
			if cart["#{name} W/COUPON"]
				cart["#{name} W/COUPON"][:count] += 1
			else
				cart["#{name} W/COUPON"] = {price: coupon[:cost], count: 1}
				cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
			end
			cart[name][:count] -= coupon[:num]
			if cart[name][:count] == 0
			end
		end
	end
cart
end


def apply_clearance(cart)
  #binding.pry
  cart.each do |item, item_hash|
  	if item_hash[:clearance] == true
  		item_hash[:price] = (item_hash[:price] * 0.80).round(2)
  	end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  total_cart = apply_clearance(couponed_cart)
  total = 0
  total_cart.each do |item, attributes|
  	total += attributes[:price] * attributes[:count]
  end
  total = total * 0.9 if total > 100
  total
end
