!SLIDE bullets
# STRING #
* most basic datatype

!SLIDE center
# For Rubyists #
    @@@ Ruby
    {:key => 'value'}
### (different than a real Ruby String, of course) ###

!SLIDE bullets
# STRING operations #
* get/set
* multiple get/set
* append
* substring

!SLIDE bullets
# STRING atomic operations #
* atomic get and set (in one step)
* set ttl while getting/setting
* check for existance while getting/setting
* increment/decrement (by)

!SLIDE bullets
# incr on a STRING??? #
* incr("3") = "4"
* incr("123 foo") = "124"
* incr(nil) = "1"
* incr("some string") = "1"

!SLIDE bullets
# decr on a STRING??? #
* decr("3") = "2"
* incr("123 foo") = "122"
* decr(nil) = "-1"
* decr("some string") = "-1"

!SLIDE bullets
# INTEGER datatype #
* maybe in redis 2.x
