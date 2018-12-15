# require 'pry'
def consolidate_cart(cart)
  p cart
  new_hash = Hash.new(0)
      hashcount = Hash.new(0)

  cart.each do |ele|

    ele.each do |key, hash|
    # p hashcount
    # p "#{ele} ||| #{cart.count(ele)}"
    p ele
# p hashcount[key]
      new_hash[key] = hash
      # if hash[:count] != nil
      #   hashcount[key] += hash[:count]
      # else
        hashcount[key] += 1
      # end
      new_hash[key][:count] = hashcount[key]
    end
  end
  # p new_hash
  return new_hash
end

# def consolidate_cart(cart)
#   p cart
#   new_hash = Hash.new(0)
#   cart.each do |ele|
#     ele.each do |key, hash|
#       hash[:count] = cart.count(ele)
#       new_hash[key] = hash
#       new_hash[key][:count] = hash[:count]
#     end
#   end
#   return new_hash
# end

def apply_coupons(cart, coupons)
  if coupons.length > 0
    new_cart = {}
    coupon_count = Hash.new(0)
    
    coupons.each do |coupon|
      coupon_count[coupon] += 1
    
      cart.each do |item, hash|
        if coupon[:item] == item
          new_cart["#{item} W/COUPON"] = {:price=>coupon[:cost], :clearance=> hash[:clearance], :count=>coupon_count[coupon]}
          hash[:count] -= coupon[:num]
        end
      new_cart[item] = hash
      end
    end
    return new_cart
  else
    return cart
  end
end

def apply_clearance(cart)
  cart.each do |item, hash|
    if hash[:clearance] == true
      hash[:price] -= hash[:price]*0.2
    end
  end
  return cart
end

def checkout(cart, coupons)
# p coupons
# p cart
  consolidate_cart(cart)
# p cart
  cart.each do |hash|
    # puts hash
    apply_coupons(hash, coupons)
    apply_clearance(hash)
    # p cart[1]
  end
  total = 0
  cart.each do |ele|
    ele.each do |item, hash|
      total += hash[:price]
    end
  end
  if total > 100
    total -= total *0.1
  end

return total
end
