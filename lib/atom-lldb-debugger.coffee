Lldb = require './debug_facade'
AtomLldbDebuggerView = require './atom-lldb-debugger-view'
{CompositeDisposable} = require 'atom'


current_row = ->
    editor = atom.workspace.getActiveTextEditor()
    cursor = editor.getCursorBufferPosition()
    return cursor.row

current_file = ->
    editor = atom.workspace.getActiveTextEditor()
    return editor.getPath()

module.exports = AtomLldbDebugger =
  atomLldbDebuggerView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomLldbDebuggerView = new AtomLldbDebuggerView(
            state.atomLldbDebuggerViewState)

    # Events subscribed to in atom's system can be easily cleaned up with a
    # CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
            'atom-lldb-debugger:toggle_breakpoint': => @toggle_breakpoint()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomLldbDebuggerView.destroy()

  serialize: ->
    atomLldbDebuggerViewState: @atomLldbDebuggerView.serialize()

  toggle_breakpoint: ->
    Lldb.toggle_breakpoint(current_file(), current_row())
