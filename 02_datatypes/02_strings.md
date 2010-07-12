!SLIDE bullets
# STRING #
* most basic datatype

!SLIDE bullets
# STRING operations #
* get/set
* multiple get/mset
* append
* substring

!SLIDE bullets
# STRING atomic operations #
* atomic get and set (in one step)
* increment/decrement (by)
* set ttl while getting/setting
* check for existance while getting/setting

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
