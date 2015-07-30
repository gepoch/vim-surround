describe "vim-surround", ->
  [editor, editorElement, workspaceElement, pairs, vimSurround, chars,
  names] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)

    waitsForPromise ->
      atom.workspace.open()

    waitsForPromise ->
      atom.packages.activatePackage('vim-surround')

    waitsForPromise ->
      atom.packages.activatePackage('vim-mode')

    waitsForPromise ->
      atom.packages.activatePackage('status-bar')

    runs ->
      editor = atom.workspace.getActiveTextEditor()
      editorElement = atom.views.getView(editor)
      pairs = ['()', '{}', '[]', '""', "''"]
      atom.config.set('vim-surround.pairs', pairs)

      commands = atom.commands.findCommands target: editorElement
      names = (command.name for command in commands when \
               command.name.substring(0,12) == 'vim-surround')
      chars = []
      pairs.forEach (pair) ->
        for i in [0..pair.length-1]
          char = pair[i]
          chars.push char unless char in chars

  describe ".activate", ->
    describe "When the config changes", ->
      beforeEach ->
        pairs = ['()', '{}', '[]', '""', "-+"]
        atom.config.set('vim-surround.pairs', pairs)
        commands = atom.commands.findCommands target: editorElement
        names = (command.name for command in commands when \
                 command.name.substring(0,12) == 'vim-surround')
        chars = []
        pairs.forEach (pair) ->
          for i in [0..pair.length-1]
            char = pair[i]
            chars.push char unless char in chars

      describe "in normal-mode", ->
        it "should add any new delete commands.", ->
          chars.forEach (char) ->
            # expect(names).toContain("vim-surround:surround-#{char}")
            expect(names).toContain("vim-surround:delete-#{char}")

        it "should remove any old delete commands.", ->
          # expect(names).not.toContain("vim-surround:surround-'")
          expect(names).not.toContain("vim-surround:delete-'")

      describe "in visual-mode", ->
        beforeEach ->
          atom.commands.dispatch(
            editorElement, "vim-mode:activate-characterwise-visual-mode")
          commands = atom.commands.findCommands target: editorElement
          names = (command.name for command in commands when \
                   command.name.substring(0,12) == 'vim-surround')

        it "should add any new surround commands.", ->
          chars.forEach (char) ->
            expect(names).toContain("vim-surround:surround-#{char}")

        it "should remove any old surround commands.", ->
          expect(names).not.toContain("vim-surround:surround-'")

    describe ".deactivate", ->
      beforeEach ->
        atom.packages.getActivePackage('vim-surround').deactivate()
        commands = atom.commands.findCommands target: editorElement
        names = (command.name for command in commands)

      it "should clear out all commands from the registry", ->
        chars.forEach (char) ->
          expect(names).not.toContain("vim-surround:surround-#{char}")
