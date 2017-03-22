import times

let local_time = getLocalTime(getTime())

let day = local_time.format("d")
let month = local_time.format("MMMM")
let year = local_time.format("yyyy")

let time = local_time.format("HH:mm")

echo("it is the " & day & " day of " & month & ", " & year & ", at " & time & ".")
