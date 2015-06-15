{CompositeDisposable} = require 'atom'

Surround = require './command/surround'
Delete = require './command/delete'
Change = require './command/change'

module.exports =
  config:
    pairs:
      type: 'array'
      default: ['()', '{}', '[]', '""', "''"]
      items:
        type: 'string'
    changeSurroundCommand:
      type: 'string'
      default: 'c s'
    deleteSurroundCommand:
      type: 'string'
      default: 'd s'
    surroundCommand:
      type: 'string'
      default: 's'

  activate: (state) ->
    @commandClasses = [
      Surround, Delete, Change
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
