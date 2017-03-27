import posix
import times
import strutils
import terminal

addQuitProc(resetAttributes)

let local_time = getLocalTime(getTime())

let day = local_time.format("d")
let month = local_time.format("MMMM")
let year = local_time.format("yyyy")

let hour = local_time.format("HH")
let minute = local_time.format("mm")

stdout.write("it is the ")
stdout.setForegroundColor(fgBlue)
stdout.write(day)
stdout.resetAttributes()
stdout.write(" day of ")
stdout.setForegroundColor(fgBlue)
stdout.write(month)
stdout.resetAttributes()
stdout.write(", ")
stdout.setForegroundColor(fgBlue)
stdout.write(year)
stdout.resetAttributes()
stdout.write(", at ")
stdout.setForegroundColor(fgGreen)
stdout.write(hour)
stdout.resetAttributes()
stdout.write(":")
stdout.setForegroundColor(fgGreen)
stdout.write(minute)
stdout.write("\n")
