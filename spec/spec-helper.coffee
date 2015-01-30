getEditorElement = (callback) ->
  textEditor = null

  waitsForPromise ->
    atom.project.open().then (e) ->
      textEditor = e

  runs ->
    element = document.createElement("atom-text-editor")
    element.setModel(textEditor)
    callback(element)

module.exports = { getEditorElement }
