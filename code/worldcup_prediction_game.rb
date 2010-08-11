require 'rubygems'
require 'active_record'
require 'redis'

n = 1000000

ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :host => "localhost",
  :username => "root",
  :database => "wc"
)

class Score < ActiveRecord::Base
end

Score.delete_all
n.times do |i|
  Score.create(:user_id => i, :score => rand(50))
end

redis = Redis.new :port => 6380
redis.flushdb
n.times {|i| redis.zadd(:scores, rand(50), i)}

Benchmark.bm do |x|
  x.report('AR:') { Score.find_by_sql('SELECT * FROM scores ORDER BY score DESC LIMIT 10') }
  x.report('Redis:') { redis.zrange :scores, 0, 9 }
end
