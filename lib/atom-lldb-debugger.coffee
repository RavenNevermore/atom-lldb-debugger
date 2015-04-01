AtomLldbDebuggerView = require './atom-lldb-debugger-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomLldbDebugger =
  atomLldbDebuggerView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomLldbDebuggerView = new AtomLldbDebuggerView(state.atomLldbDebuggerViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomLldbDebuggerView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-lldb-debugger:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomLldbDebuggerView.destroy()

  serialize: ->
    atomLldbDebuggerViewState: @atomLldbDebuggerView.serialize()

  toggle: ->
    console.log 'AtomLldbDebugger was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
