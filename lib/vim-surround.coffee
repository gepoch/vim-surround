{CompositeDisposable} = require 'atom'

Surround = require './command/surround'

module.exports =
  config:
    pairs:
      type: 'array'
      default: ['()', '{}', '[]', '""', "''"]
      items:
        type: 'string'
    surroundCommand:
      type: 'string'
      default: 's'

  activate: (state) ->
    @commandClasses = [
      Surround
    ]

    @configLoop = atom.config.observe 'vim-surround', (config) =>
      @disposables.dispose() if @disposables?
      @disposables = new CompositeDisposable

      @commands = []

      for cls in @commandClasses
        command = new cls config
        @commands.push command
        @disposables.add command.disposables

  deactivate: () ->
    @disposables.dispose()
