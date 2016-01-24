# config/initializers/array.rb

class Array

  def multiset(arr)
    result=[]
    h1,h2=Hash.new(0),Hash.new(0)
    self.each { |x| h1[x] += 1 }
    arr.each { |x| h2[x] += 1 }
    h1.each_pair { |k,v| result << [k] * [v, h2[k]].min if h2[k] != 0 }
    result.flatten
  end

end