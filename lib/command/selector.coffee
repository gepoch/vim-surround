vimModePath = atom.packages.resolvePackagePath('vim-mode') or
              atom.packages.resolvePackagePath('vim-mode-next')

{SelectInsideQuotes, SelectInsideBrackets} = require "#{vimModePath}/lib/text-objects"

module.exports = class Selector
  constructor: (@editor, left, right) ->
    @left = left.trim()
    @right = right.trim()

  inside: ->
    if @isBraket()
      new SelectInsideBrackets(@editor, @left, @right, false)
    else
      new SelectInsideQuotes(@editor, @left, false)

  outside: ->
    if @isBraket()
      new SelectInsideBrackets(@editor, @left, @right, true)
    else
      new SelectInsideQuotes(@editor, @left, true)

  isBraket: ->
    ['[', ']', '{', '}', '<', '>', '(', ')'].indexOf?(@left.trim()) >= 0
