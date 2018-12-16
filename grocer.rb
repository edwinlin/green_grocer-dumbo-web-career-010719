def consolidate_cart(cart) #is a hash
  new_hash = {}

  cart.each do |ele|
    ele.each do |key, hash1|
      if new_hash[key].nil?
        new_hash[key] = hash1
        new_hash[key][:count] = 1
      else
        new_hash[key][:count] += 1
      end
    end
  end
  return new_hash
end

def apply_coupons(cart, coupons) #cart is a hash
  if coupons.length > 0   #check if there is a coupon
    new_cart = {}
    coupon_count = Hash.new(0)
    
    coupons.each do |coupon|
      coupon_count[coupon] += 1
    
      cart.each do |item, hash|
        if coupon[:item] == item
          if hash[:count] >= coupon[:num]
            new_cart["#{item} W/COUPON"] = {:price=>coupon[:cost], :clearance=> hash[:clearance], :count=>coupon_count[coupon]}
            hash[:count] -= coupon[:num]
          end
        end
      new_cart[item] = hash
      end
    end
    return new_cart
  else
    return cart
  end
end

def apply_clearance(cart) #cart is an array
  cart.each do |item, hash1|
    if hash1[:clearance] == true
      hash1[:price] -= (hash1[:price]*0.2).round(1)
    end
  end
  return cart
end

def checkout(cart, coupons) 
  cart2 = consolidate_cart(cart)
  couponed_cart = apply_coupons(cart2, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  total = 0
  final_cart.each do |item, hash2|
      total += hash2[:price] * hash2[:count]
  end
  if total > 100
    total -= total *0.1
  end

return total
end
