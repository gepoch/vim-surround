{CompositeDisposable} = require 'atom'

SurroundCommand = require './surround-command'

module.exports =
  config:
    pairs:
      type: 'array'
      default: ['()', '{}', '[]', '""', "''"]
      items:
        type: 'string'
    commands:
      type: 'object'
      properties:
        surround:
          type: 'string'
          default: 's'

  activate: (state) ->
    @commandClasses = [
      SurroundCommand
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
