require 'pry'

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
  cart.each do |item, info|
    if info[:clearance]
      info[:price] = (info[:price] * 0.8).round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated, coupons)
	# binding.pry
  clearance_applied = apply_clearance(coupons_applied)
  total = 0

  clearance_applied.each do |item, info|
    total += info[:price] * info[:count]
  end

  if total > 100
    total = (total * 0.9).round(2)
    return total
  else
    return total
  end
end

# cart = [
#   {"AVOCADO" => {:price => 3.00, :clearance => true}},
#   {"AVOCADO" => {:price => 3.00, :clearance => true}},
#   {"CHEESE" => {:price => 6.50, :clearance => false}},
#   {"CHEESE" => {:price => 6.50, :clearance => false}},
#   {"CHEESE" => {:price => 6.50, :clearance => false}},
#   {"SOY MILK" => {:price => 4.50, :clearance => true}}
# ]
#
# coupons = [
#   {:item => "AVOCADO", :num => 2, :cost => 5.00},
#   {:item => "CHEESE", :num => 3, :cost => 15.00}
# # ]
# beer = {"BEER" => {:price => 13.00, :clearance => false}}
# cart = Array.new(3, beer)
# coupons = [{:item => "BEER", :num => 2, :cost => 20.00},{:item => "BEER", :num => 2, :cost => 20.00}]
# consolidated = consolidate_cart(cart)
# p apply_coupons(consolidated, coupons)
# p checkout(cart, coupons)
