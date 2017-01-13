class @ActionCommentFactory
  construct: (danmaku)->
    @danmaku = danmaku

  makeComment: (text)->
    switch text
      when "今何時？" then return new ActionCommentClock(text)
      else return new Comment(text)
