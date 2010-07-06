require 'rubygems'
require 'redis'
require 'json'
require 'benchmark'

@redis = Redis.new()

Employee = Struct.new(:id, :name, :salary)

n = 1000000
Benchmark.bm do |x|
  # Daten einfügen
  x.report do
    n.times do |i|
      employee = Employee.new(i+1, "employee_name_#{i}", rand(100000))
      @redis.set("employee_#{i+1}", employee.to_a.to_json)
      print "\r#{i} employees created" if i % 10000 == 0
    end
    puts "\rAll Employees created"
  end
  
  # Random lookup
  x.report do
    100000.times do |i|
      employee = Employee.new(*JSON.parse(@redis.get("employee_#{rand(n+1)}")))
    end
  end
end

#       user     system      total        real
# All Employees created
#  37.090000  18.020000  55.110000 (101.434106)
#   4.150000   2.040000   6.190000 ( 11.489005)