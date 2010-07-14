!SLIDE
# How to put data into Redis? #

!SLIDE
# Simple example: #
# Users and their attributes #

!SLIDE
# How stuff looks in plain Redis #
    user:1:name = 'Frank'
    user:1:sex = 'm'
    user:2:name = 'Betty'
    user:2:sex = 'f'
    user:all = Set.new [1, 2]
    user:id = '2'

!SLIDE bullets
# Now give me all female users! #
* not possible with the current data model

!SLIDE
# Possible solution #
    user:1:name = 'Frank'
    user:1:sex = 'm'
    user:2:name = 'Betty'
    user:2:sex = 'f'
    user:all = Set.new [1, 2]
    user:male = Set.new [1]
    user:female = Set.new [2]
    user:id = '2'
