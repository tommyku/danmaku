class @WeightedList
  @array
  constructor: (array)->
    @array = array

  sample: ->
    total = @array.reduce (prev, val)->
      prev + val.weight
    , 0
    key = Math.floor Math.random()*total
    for item in @array
      key -= item.weight
      continue unless key <= 0
      return item

  getArray: ->
    @array
