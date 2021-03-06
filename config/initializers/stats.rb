#  Add methods to Enumerable, which makes them available to Array
module Enumerable
 
  #  sum of an array of numbers
  def sum
    return self.inject(0){|acc,i|acc +i}
  end
 
  #  average of an array of numbers
  def average
    return self.sum/self.length.to_f
  end
 
  #  variance of an array of numbers
  def sample_variance
    avg=self.average
    sum=self.inject(0){|acc,i|acc +(i-avg)**2}
    return(1/self.length.to_f*sum)
  end
 
  #  standard deviation of an array of numbers
  def standard_deviation
    return Math.sqrt(self.sample_variance)
  end

  # median of an array of numbers
  def median
    sorted = self.sort
    len = sorted.length
    return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end

  #Inject an array until there are 3 entries
  def insert_values(x)
    until self.length > 2
      self.push(x)
    end
    return self
  end

 
end  #  module Enumerable