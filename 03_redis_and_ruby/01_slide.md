!SLIDE 
# Redis with ruby #


!SLIDE ruby
# redis-rb #
    @@@ ruby
    require 'redis'
    r = Redis.new

                  
!SLIDE ruby
# defaults #
    @@@ ruby
    { :host => "127.0.0.1",
      :port => 6379,
      :db => 0,
      :timeout => 5,
      :password => nil,
      :logger => nil }


!SLIDE bullet
# working with string values #
                  

!SLIDE ruby 

    @@@ ruby
    r.set "some_key", "special value"
     => "OK"
    r.get "some_key"
     => "special value"

     
!SLIDE bullet 
# or more ruby-like... #


!SLIDE ruby 

    @@@ ruby
    r["some_key"] = "value 2"
     => "value 2"
    r["some_key"]
     => "value 2"
     

!SLIDE ruby
# working with lists #

!SLIDE ruby

    @@@ ruby
    3.times do |i|
      r.lpush "my_list", i+1
    end
    
    r.lrange "my_list", 0, -1
     => ["3", "2", "1"]

    
!SLIDE ruby

    @@@ ruby
    r.lpop "my_list"
     => "3"
    r.rpop "my_list"
     => "1"
    r.llen "my_list"
     => 1

    
!SLIDE bullets
# Ohm #
* Object-hash mapping library


!SLIDE ruby
    @@@ ruby
    class Person < Ohm::Model
      attribute :name
    end

    
!SLIDE ruby
    @@@ ruby
    Person.create :name => "mark"
     => #<Person:1 name="mark"> 
    
    
!SLIDE ruby
    @@@ ruby
    p = Person.new
    p.name = "ralph"
    p.save
     => #<Person:2 name="ralph"> 
    
    
!SLIDE ruby
    @@@ ruby
    "Person:1:name" [string] => "mark"
    "Person:2:name" [string] => "ralph"
    "Person:all"    [set]    => ["1", "2"]
    "Person:id"     [string] => "2"

    
!SLIDE bullets
# associations
# validations

    
!SLIDE ruby
    @@@ ruby
    class Post < Ohm::Model
      attribute :title
      attribute :body
      reference :author, Person
      index :title

      def validate
        assert_present :title
      end
    end


!SLIDE ruby
    @@@ ruby
    p = Post.new
    p.valid?
     => false
    p.title = "redis is awesome!"
    p.valid?
     => true
    p.author = Person[1]
    p.save

    
!SLIDE ruby
    @@@ ruby
    "Post:1:_indices"     [set]    => 
                    ["Post:title:YXNkZg==",
                     "Post:author_id:MQ=="]
    "Post:1:author_id"    [string] => "1"
    "Post:1:title"        [string] => "asdf"
    "Post:id"             [string] => "1"
    "Post:all"            [set]    => ["1"]
    "Post:author_id:MQ==" [set]    => ["1"]
    "Post:title:YXNkZg==" [set]    => ["1"]
    
    # "MQ=="     == Base64.encode64("1")
    # "YXNkZg==" == Base64.encode64("asdf")

    
!SLIDE bullets
# query-interface #


!SLIDE ruby
    @@@ ruby
    Post[1]
    Post.all
    Post.find(:title => "some title")\
        .sort_by(:title)


!SLIDE bullets
# redis-objects
## "People that are wrapping ORM’s around Redis are missing the point" ##


!SLIDE ruby
## standalone usage ##
    @@@ ruby
    require 'redis'
    require 'redis/list'
    
    redis = Redis.new
    list = Redis::List.new("mylist", redis)
    list << "a"
    list.include? "b" # false

    
!SLIDE ruby
## complex data types ##
    @@@ ruby
    @list = Redis::List.new("mylist", redis, 
                            :marshal => true)
    @list << {:title => "redis is awesome!", 
              :author => "mark"}

    
!SLIDE bullets
# integrate redis-objects into your AR-Model #


!SLIDE ruby
    @@@ ruby
    class Post < AR:Base
      include Redis::Objects
      
      list :comments
      set :tags
      value :author_url
    end


!SLIDE ruby
    @@@ ruby
    p = Post.find_by_title("redis is awesome!")
    p.comments << "great lib!"
    p.author_url = "somewhere"


!SLIDE bullets
# What's about performance? #


!SLIDE ruby
    @@@ ruby
    class Employee < AR::Base
    end
    
    # insert some data
    1_000_000.times do |i|
      Employee.create(:name => "employee_#{i}",
                      :salary => rand(100000))
    end

    # fetching some data
    100000.times do |i|
      Employee.find(rand(n+1))
    end
    
    
!SLIDE bullets
## insert: 1931s ##
##  fetch: 59s   ##

!SLIDE bullets
# and now with redis... #

!SLIDE ruby
    @@@ ruby
    Employee = Struct.new(:id, :name, :salary)
    
    # insert some data
    1_000_000.times do |i|
      e = Employee.new(i+1, "employee_#{i}", 
                       rand(100000))
      redis.set("employee_#{i+1}",e.to_a.to_json)
    end

    # fetching some data
    100000.times do |i|
      Employee.new(*JSON.parse(
        redis.get("employee_#{rand(n+1)}")))
    end

!SLIDE bullets
## insert: 101s => 10 times faster ##
## fetch: 11s => 6 times faster ##