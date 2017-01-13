class @Scene
  constructor: (danmaku, options={})->
    console.log 'scene'
    @danmaku = danmaku
    @interval
    @options = _.defaults(options, {
      tickDuration: 500
    })
    @startTick()
    @

  startTick: ->
    @stopTick() if @interval
    @interval = setInterval ()=>
      @onTick()
    , @options.tickDuration

  stopTick: ->
    clearInterval(@interval)
    delete @interval

  onTick: ->
    return
