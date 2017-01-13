# dependencies:
# - Comment

class @ActionComment extends @Comment
  constructor: (text='[undefined]', options={})->
    super(text, options)

  start: ->
    super()
    @onStart()

  destroyAfterPlay: ()->
    super()
    @onFinish()

  onStart: ->
    setTimeout ()=>
      @danmaku.add(new Comment('機械はじさ…というか自爆はしないのか', {color: 'white'}))
    , 2000
    console.info 'action comment start'

  onFinish: ()->
    console.info 'action comment finish'
