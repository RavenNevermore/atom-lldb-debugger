

breakpoints = {}

add_breakpoint = (file, line) ->
    unless breakpoints[file]?
        breakpoints[file] = []

    breakpoints[file][breakpoints[file].length] = line

remove_breakpoint = (file, line) ->
    breakpoints[file] = breakpoints[file].filter (bp) ->
        bp isnt line

breakpoint_exists = (file, line) ->
    return breakpoints[file]? and (line in breakpoints[file])

this.toggle_breakpoint = (file, line) ->
    if breakpoint_exists(file, line)
        remove_breakpoint(file, line)
    else
        add_breakpoint(file, line)

    console.log "Breakpoints for #{file}: #{breakpoints[file]}"
