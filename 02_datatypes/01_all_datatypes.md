!SLIDE
# What can you do with the different datatypes? #

!SLIDE bullets
# ALL Datatypes #
* rename
* delete
* get type
* check for existance

!SLIDE bullets
# TTL operations
* expire (set ttl)
* get ttl

!SLIDE
# Atomic transactions #
    MULTI
    ...
    SET chicken egg
    SET egg chicken
    ...
    EXEC
