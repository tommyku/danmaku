# dependencies:
# - jquery.js
# - underscore.js

class @Danmaku
  constructor: (selector, options={})->
    @dom = $(selector)
    @actionCommentFactory = new ActionCommentFactory(@)
    @options = options
    @ueQueue = []
    @shitaQueue = []
    @middleQueue = []
    @buildUI()

  add: (comment)->
    unless (comment instanceof Comment)
      throw new Error('First arguemnt must be an instance of Comment')
    if comment.isUe()
      @ueQueue.push(comment)
    if comment.isMiddle()
      @middleQueue.push(comment)
    if comment.isShita()
      @shitaQueue.push(comment)
    comment.setDanmaku @
    comment.render()

  renderComment: (comment)->
    @dom.append(comment.renderDom())
    comment.start()
    setTimeout ()=>
      @unsetComment(comment)
    , comment.getDuration()

  unsetComment: (comment)->
    if comment.isUe()
      @ueQueue =  _.without(@ueQueue, comment)
    if comment.isMiddle()
      @middleQueue = _.without(@middleQueue, comment)
    if comment.isShita()
      @shitaQueue = _.without(@shitaQueue, comment)
    comment.destroyAfterPlay()

  onNewComment: (e)->
    input = $(e.target)
    text = input.val()
    @add(@actionCommentFactory.makeComment(text))
    input.val('')

  buildUI: ()->
    input = $ '<input>',
      type: 'text',
      style: 'position: fixed; bottom: 0; width: 100%; z-index: 999999; padding: 0.5em 1em;',
      placeholder: 'コメントしましょ'
    input.on 'keyup', (e)=>
      if e.keyCode == 13
        @onNewComment(e)
    @dom.append input
