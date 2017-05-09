import posix
import times
import strutils
import terminal

proc daySuffix(day: string): string =
  let day_end_digit = $day[day.high()]
  case day_end_digit
  of "1":
    return "st"
  of "2":
    return "nd"
  of "3":
    return "rd"
  else:
    return "th"

addQuitProc(resetAttributes)

let local_time = getLocalTime(getTime())

let weekday = local_time.format("dddd")
let day = local_time.format("d")
let suffix = day.daySuffix()
let month = local_time.format("MMMM")
let year = local_time.format("yyyy")

let hour = local_time.format("HH")
let minute = local_time.format("mm")

stdout.write("it is ")
stdout.setForegroundColor(fgBlue)
stdout.write(weekday)
stdout.resetAttributes()
stdout.write(", the ")
stdout.setForegroundColor(fgBlue)
stdout.write(day)
stdout.write(suffix)
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
