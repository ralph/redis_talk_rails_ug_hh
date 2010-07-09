!SLIDE 
# Redis with ruby #

!SLIDE ruby 
# redis-rb #
## working with string values ##
    @@@ ruby
    require 'redis'
    r = Redis.new

    r.set "some_key", "special value"
    => "OK"
    r.get "some_key"
    => "special value"
    r["some_key"] = "value 2"
    => "value 2"
    r["some_key"]
    => "value 2"

!SLIDE ruby
# redis-rb #
## working with lists ##

    @@@ ruby
    3.times do |i|
      r.lpush "my_list", i+1
    end
    
    r.lrange "my_list", 0, -1
    => ["3", "2", "1"]
    
    r.lpop "my_list"
    => "3"
    r.rpop "my_list"
    => "1"
    r.llen "my_list"
    => 1
    
