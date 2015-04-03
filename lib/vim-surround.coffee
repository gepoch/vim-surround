{Disposable, CompositeDisposable} = require 'event-kit'
Surround = require './surround'

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
      # change:
      #   type: 'string'
      #   default: 'c s'
      # delete:
      #   type: 'string'
      #   default: 'd s'

  activate: (state) ->
    @configLoop = atom.config.observe 'vim-surround', @setup

  setup: (config) ->
    @disposables.dispose() if @disposables?
    @disposables = new CompositeDisposable

    @commandClasses = [
      Surround
    ]
    @commands = []

    for cls in @commandClasses
      command = new cls config
      @commands.push command
      @disposables.add command.disposables

  deactivate: () ->
    @disposables.dispose()
    @configLoop.dispose()
