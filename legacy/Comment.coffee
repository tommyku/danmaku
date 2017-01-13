# dependencies:
# - jquery.js
# - move.js

class @Comment
  Size:
    small: 1
    normal: 2
    big: 4

  Position:
    ue: 1
    middle: 2
    shita: 3

  Color:
    white: '#ffffff'
    red: '#ff4136'
    pink: '#F012BE'
    orange: '#FF851B'
    yellow: '#FFDC00'
    green: '#F012BE'
    cyan: '#7FDBFF'
    blue: '#0074D9'
    purple: '#B10DC9'
    black: '#000000'

  constructor: (text='[undefined]', options={})->
    @danmaku
    @dom
    @text = text
    @options = _.defaults(options, {
      size: @Size.normal
      position: @Position.middle
      color: @Color.white
      debug: false
    })

  start: ->
    @dom.css(@positionStyle())
    return unless @isMiddle()
    move("#"+@dom.attr('id'))
      .x(-"#{$(window).width()+@dom.width()}")
      .duration("#{@getDuration()/1000}s")
      .ease('linear')
      .end()

  render: ->
    return unless @danmaku
    @danmaku.renderComment(@)

  renderDom: ->
    @dom = $ '<div>', {
      text: @text,
      id: "comment-"+Math.trunc(Math.random()*10000).toString()
    }
    @dom.css(@styles())
    @dom

  styles: ->
    cssStyles = _.extend {
      position: 'fixed'
      opacity: 0.9
      color: @options.color
      'font-weight': 700
      'font-size': @options.size+'rem'
    }, @positionStyle()

  positionStyle: ->
    if @isUe()
      return { top: "#{@dom.height()*(@danmaku.ueQueue.length-1)%(@dom.height()*5)}px", left: 0, right: 0, 'text-align': 'center', margin: 'auto' }
    if @isShita()
      return { bottom: "#{26+@dom.height()*(@danmaku.shitaQueue.length-1)%(@dom.height()*5)}px", left: 0, right: 0, 'text-align': 'center', margin: 'auto' }
    if @isMiddle()
      return { right: "-#{@dom.width()}px", top: @dom.height()*(@danmaku.middleQueue.length-1)%(@dom.height()*7) }

  setDanmaku: (danmaku)->
    @danmaku = danmaku

  destroyAfterPlay: ()->
    @dom.remove()

  isUe: ->
    @options.position == @Position.ue

  isMiddle: ->
    @options.position == @Position.middle

  isShita: ->
    @options.position == @Position.shita

  getDuration: ->
    if @isUe() || @isShita()
      2000
    else
    Math.min(1000/@dom.width()*4600, 5000)
