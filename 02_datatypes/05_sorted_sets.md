!SLIDE bullets
# SORTED SET #
* own datatype, no extension of SET
* score = float representing the sort position

!SLIDE bullets
# What do we lose from SET? #
* simple union, diff, intersection
* random member

!SLIDE bullets
# What do we gain? #
* items by score
* items by rank (e.g. the first 10 items)

!SLIDE bullets
# For each member item #
* get the rank
* get the score
* increment the score

!SLIDE bullets
# Of course you can do the usual stuff #
* like adding and removing items.
