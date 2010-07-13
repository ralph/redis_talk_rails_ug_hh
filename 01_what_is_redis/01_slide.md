!SLIDE 
# Redis #
# A fast key-value store #

!SLIDE smbullets
# What we will talk about: #

* What is redis?
* Which datatypes does it support?
* Which operations can you perform in each of the datatypes?
* How to use Redis with Ruby?
* Real world usage examples

!SLIDE
# What is redis? #

!SLIDE
# REmote DIctionary Server #

!SLIDE
# A key value store. #

!SLIDE
# Think: #
    @@@ Ruby
    {:key => 'value', :ruby => 'awesomeness'}

!SLIDE bullets
# BUT! #
* over the network
* with complex datatypes
* with atomic operations

!SLIDE bullets
# More features... #
* expiry
* master/slave replication
* notifications (publish/subscribe)
* different persistence modes (from fast to secure)

!SLIDE bullets
# And most importantly...#
* Crazily fast!
* Multiple 10.000 operations/sec on a laptop

!SLIDE
# Show me an example! (1/2) #
    @@@ Ruby
    # Ruby land:
    h = {}
    h[:my_key] = 'my_value'
    => "my_value"

    # Redis land:
    redis.set :my_key, 'my_value'
    => "OK"

!SLIDE
# Show me an example! (2/2) #
    @@@ Ruby
    # Ruby land:
    h[:my_key]
    => "my_value"

    # Redis land:
    redis.get :my_key
    => "my_value"

!SLIDE bullets
# What more can I do with it??? #
* It all boils down to saving/retrieving strings
* But this is already a lot!

!SLIDE bullets incremental
# The keys... #
* Needed for every operation

!SLIDE bullets
# Sample format: #
* article:123:title
* comment:456:body
* model:id:attribute

!SLIDE
# The values... #

!SLIDE bullets
# Datatypes #
* String
* List
* Set
* Sorted Set
* Hash
