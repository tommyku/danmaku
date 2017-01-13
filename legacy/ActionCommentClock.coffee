# dependencies:
# - ActionComment

class @ActionCommentClock extends @ActionComment
  constructor: (text='[undefined]', options={})->
    super(text, options)

  onStart: ->
    setTimeout ()=>
      now = new Date()
      @danmaku.add(
        new Comment("#{now.getHours()}時です", {
          color: 'red', position: 1, size: 3
        })
      )
    , Math.random()*1500+1000
    console.info 'action comment clock start'

  onFinish: ()->
    console.info 'action comment clock finish'
