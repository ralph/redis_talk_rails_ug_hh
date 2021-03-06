!SLIDE
# Worldcup prediction game #

!SLIDE bullets
# How it works #
* Users can predict a game
* right match score: 3 points
* right match winner: 1 point
* points are added to the user's score attribute

!SLIDE bullets
# In SQL: Table #
* columns user\_id and score

!SLIDE bullets
# In Redis: sorted sets #
* items: user ids
* item scores: based on prediction success

!SLIDE bullets
# We want a top 10 list! #
* 1: Mr. Foo (58 points)
* 2: Mrs. Bar (56 points)
* ...
* 10: Mr. Guybrush Threepwood (42 points)

!SLIDE
# Get the top 10 list with SQL #
    @@@ SQL
    SELECT * FROM scores
    ORDER BY score DESC
    LIMIT 10;

!SLIDE
# Get the top 10 list with Redis #
    ZRANGE scores 0 9

!SLIDE bullets
# The benchmark #
* 1.000.000 entries
* Redis: ~0.3 ms
* SQL: ~165 ms (Redis ~550 times faster)
* indexed SQL: ~0.6 ms (Redis 2 times faster)

!SLIDE bullets
# Similar case: Reputation points #
* e.g. in forums, social networks etc.

