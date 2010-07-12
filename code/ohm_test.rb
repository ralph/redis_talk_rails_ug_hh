require 'ohm'

class Post < Ohm::Model
  attribute :title
  attribute :body
  reference :author, Person
  index :title
  
  def validate
    assert_present :title
  end
end

class Category < Ohm::Model
  attribute :name
end

class Person < Ohm::Model
  attribute :name
end

def inspect_redis
  r = Redis.new
  r.keys.sort.each do |key|
    puts "#{key} [#{type = r.type(key)}]: #{type == "set" ? r.smembers(key).inspect : r.get(key).inspect}"
  end
end


# ruby-1.8.7-p299 > inspect_redis
# Category:1:name [string]: "Ruby"
# Category:all [set]: ["1"]
# Category:id [string]: "1"
# Person:1:name [string]: "Mark"
# Person:all [set]: ["1"]
# Person:id [string]: "1"
# Post:1:_indices [set]: ["Post:author_id:MQ=="]
# Post:1:author_id [string]: "1"
# Post:1:body [string]: "lorem ipsum..."
# Post:1:title [string]: "redis is awsome"
# Post:2:_indices [set]: ["Post:author_id:"]
# Post:2:title [string]: "redis is awsome"
# Post:all [set]: ["1", "2"]
# Post:author_id: [set]: ["2"]
# Post:author_id:MQ== [set]: ["1"]
# Post:id [string]: "2"

# problems:
#  - Category.all => NoMethodError: undefined method `each' for nil:NilClass (wenn keine vorhanden, scheint ein problem von Ohm::Model#inspect zu sein)