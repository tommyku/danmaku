class @InfiniteDanmaku extends @Scene
  constructor: (text, danmaku, options={})->
    super(danmaku, options)
    @text = text

  onTick: ->
    @danmaku.add(new Comment(@text), {color: 'white'})
