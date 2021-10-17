require 'benchmark'
require_relative "custom_enumerables.rb"

f = File.open('results.txt',"w")
f.write("my_each vs. each\n")
p 'my_each vs. each'
numbers = [1, 2, 3, 4, 5]
test_hash = {a:'1', b:"2", c:"3", d:"4", e:"5"}
time = Benchmark.measure{
  numbers.my_each { |item| puts "value = #{item}" }
  test_hash.my_each { |item| puts "value = #{item}" }
}
f.write("#{time}\n")
time = Benchmark.measure{
  numbers.each { |item| puts "value = #{item}" }
  test_hash.each { |item| puts "value = #{item}" }
}
f.write("#{time}\n")

f.write("my_each_with_index vs. each_with_index\n")
p 'my_each_with_index vs. each_with_index'
time = Benchmark.measure{
  numbers.my_each_with_index { |item, index| puts "value = #{item}, index = #{index}" }
  test_hash.my_each_with_index { |item, index| puts "value = #{item}, index = #{index}" }
}
f.write("#{time}\n")
time = Benchmark.measure{
  numbers.each_with_index { |item, index| puts "value = #{item}, index = #{index}" }
  test_hash.each_with_index { |item, index| puts "value = #{item}, index = #{index}" }
}
f.write("#{time}\n")

f.write("my_select vs. select\n")
p 'my_select vs. select'
time = Benchmark.measure{
  p numbers.my_select  { |item| item.even?}
  p test_hash.my_select  { |key, value| value.to_i.odd?}
}
f.write("#{time}\n")
time = Benchmark.measure{
  p numbers.select  { |item| item.even?}
  p test_hash.select  { |key, value| value.to_i.odd?}
}
f.write("#{time}\n")

numbers = [1,1,1,1,1]
f.write("my_all? vs. all?\n")
p 'my_all? vs. all?'
time = Benchmark.measure{
  p numbers.my_all?(Numeric)
  p numbers.my_all?(Integer)
  p numbers.my_all?(1)
  p numbers.my_all? {|value| value-1 == 0}
  p numbers.my_all?("1")
}
f.write("#{time}\n")
time = Benchmark.measure{
  p numbers.all?(Numeric)
  p numbers.all?(Integer)
  p numbers.all?(1)
  p numbers.all? {|value| value-1 == 0}
  p numbers.all?("1")
}
f.write("#{time}\n")


numbers = [1,1,"A",1,1]
f.write("my_none? vs. none?\n")
p 'my_none? vs. none?'
time = Benchmark.measure{
  p numbers.my_none?(Numeric)
  p numbers.my_none?(Integer)
  p numbers.my_none?(1)
  p numbers.my_none?(2)
  p numbers.my_none? {|value| value-1 == 0}
  p numbers.my_none?("1")
}
f.write("#{time}\n")
time = Benchmark.measure{
  p numbers.none?(Numeric)
  p numbers.none?(Integer)
  p numbers.none?(1)
  p numbers.none?(2)
  p numbers.none? {|value| value-1 == 0}
  p numbers.none?("1")
}
f.write("#{time}\n")

numbers = [1,1,2,3,1]
f.write("my_count vs. count\n")
p 'my_count vs. count'
time = Benchmark.measure{
  p numbers.my_count(Numeric)
  p numbers.my_count(Integer)
  p numbers.my_count(1)
  p numbers.my_count(2)
  p numbers.my_count {|value| value-1 == 0}
  p numbers.my_count("1")
}
f.write("#{time}\n")
time = Benchmark.measure{
  p numbers.count(Numeric)
  p numbers.count(Integer)
  p numbers.count(1)
  p numbers.count(2)
  p numbers.count {|value| value-1 == 0}
  p numbers.count("1")
}
f.write("#{time}\n")

numbers = [1,1,2,3,1]
hash = { bacon: "protein", apple: "fruit" }
strings = ["1", "2", "3"]
f.write("my_map vs. map\n")
p 'my_map vs. map'
time = Benchmark.measure{
  p numbers.my_map { |n| n*2 }
  p numbers.my_map { |n| n-1 }
  p hash.my_map { |k,v| [k, v.to_sym] }.to_h
  p strings.my_map(&:to_i)
}
f.write("#{time}\n")
time = Benchmark.measure{
  p numbers.map { |n| n*2 }
  p numbers.map { |n| n-1 }
  p hash.map { |k,v| [k, v.to_sym] }.to_h
  p strings.map(&:to_i)
}
f.write("#{time}\n")

f.write("my_inject vs. inject\n")
p 'my_inject vs. inject'
time = Benchmark.measure{
  p [3, 6, 10].my_inject {|sum, number| sum + number}
  p [3, 6, 10].my_inject(3) {|sum, number| sum + number}
  p (5..10).my_inject { |sum, n| sum + n }
  p (5..10).my_inject(:+)
  p [2,4,5].my_inject { |sum, n| sum * n }
  p [2,4,5].my_inject(:*)
}
f.write("#{time}\n")
time = Benchmark.measure{
  p [3, 6, 10].inject {|sum, number| sum + number}
  p [3, 6, 10].inject(3) {|sum, number| sum + number}
  p (5..10).inject { |sum, n| sum + n }
  p (5..10).inject(:+)
  p [2,4,5].inject { |sum, n| sum * n }
  p [2,4,5].inject(:*)
}
f.write("#{time}\n")
f.close
