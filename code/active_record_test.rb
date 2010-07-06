require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :host => "localhost",
  :username => "root",
  :database => "redis_test")

class Employee < ActiveRecord::Base
end

n = 1000000
Benchmark.bm(7) do |x|
  # Daten einfügen
  x.report("Insert:") do
    n.times do |i|
      Employee.create(:name => "employee_name_#{i}", :salary => rand(100000))
      print "\r#{i} employees created" if i % 10000 == 0
    end
    puts "\rAll Employees created"
  end
  
  # Random lookup
  x.report do
    100000.times do |i|
      employee = Employee.find(rand(n+1))
    end
  end
end

#              user     system      total        real
# All Employees created
# 1143.150000  70.730000 1213.880000 (1931.455067)
#   39.180000   2.250000   41.430000 ( 58.751133)