def consolidate_cart(cart)
  # code here
  hashy = {}

  cart.each do |item|
    name = item.keys[0]

    hashy[name] = item.values[0]

    if hashy[name][:count]
      hashy[name][:count] += 1
    else
      hashy[name][:count] = 1
  end
end
  hashy
end

def apply_coupons(cart, coupons)
  # code here
  hashy = {}
  coupons.each do |coupon|
    yum = coupon[:item]

    if !cart[yum].nil? && cart[yum][:count] >= coupon[:num]
      tempy = {"#{yum} W/COUPON" => {
      price: coupon[:cost],
      clearance: cart[yum][:clearance],
      count: 1
      }
      }
      if cart["#{yum} W/COUPON"].nil?
        cart.merge!(tempy)
      else
        cart["#{yum} W/COUPON"][:count] += 1
      end
      cart[yum][:count] -= coupon[:num]
  end
end
cart
end

def apply_clearance(cart)
  # code here
  cart.collect do |food, stats|
    if stats[:clearance] == true
      stats[:price] -= (stats[:price] * 0.2 )
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here

  cons = consolidate_cart(cart)
  first = apply_coupons(cons, coupons)
  second = apply_clearance(first)

  total = 0

  second.each_value do |stats|
    total += stats[:price] * stats[:count]
  end

  if total > 100
    total *= 0.9
  end


  total
end
