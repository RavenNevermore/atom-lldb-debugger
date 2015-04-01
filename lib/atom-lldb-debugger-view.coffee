module.exports =
class AtomLldbDebuggerView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atom-lldb-debugger')



  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  updateUi: ->
      editor = atom.workspace.getActiveTextEditor()

      marker = editor.markBufferRange([[8,0], [8,0]], invalidate: 'never')
      editor.decorateMarker(    marker,
                                type: 'gutter',
                                class: 'breakpoint')
