
# =======
# Imports
# =======

import times
import strutils
import terminal
import strformat

import commandeer

# =====
# Types
# =====

type
  ColorFlagOptions = enum
    Auto,
    Always,
    Never

# =========
# Constants
# =========

const
  NimblePkgVersion {.strdefine.} = ""
  NimblePkgName {.strdefine.} = ""

# =========
# Templates
# =========

template color(color: untyped, body: untyped) =
  block:
    if display_color != Never:
      stdout.setForegroundColor(color)
    body
    if display_color != Never:
      stdout.resetAttributes()

# =========
# Functions
# =========

proc daySuffix(day: string): string =
  let day_end_digit = $(day[day.high()])
  case day_end_digit
  of "1":
    return "st"
  of "2":
    return "nd"
  of "3":
    return "rd"
  else:
    return "th"

# ==========
# Main Entry
# ==========

proc main() =
  let local_time = local(now())

  let weekday = local_time.format("dddd")
  let day = local_time.format("d")
  let suffix = daySuffix(day)
  let month = local_time.format("MMMM")
  let year = local_time.format("yyyy")

  let hour = local_time.format("HH")
  let minute = local_time.format("mm")

  commandline:
    option ColorFlag, string, "color", "c", "auto"
    exitoption "help", "h", fmt"{NimblePkgName} [-h|--help] [-v|--version] [-c|--color:<auto|always|never>]"
    exitoption "version", "v", fmt"{NimblePkgName} v{NimblePkgVersion}"

  var display_color = parseEnum[ColorFlagOptions](ColorFlag)
  if display_color == Auto:
    display_color =
      if isatty(stdout): Always
      else: Never

  stdout.write("it is ")
  color(fgBlue):
    stdout.write(weekday)
  stdout.write(", the ")
  color(fgBlue):
    stdout.write(day)
    stdout.write(suffix)
  stdout.write(" day of ")
  color(fgBlue):
    stdout.write(month)
  stdout.write(", ")
  color(fgBlue):
    stdout.write(year)
  stdout.write(", at ")
  color(fgGreen):
    stdout.write(hour)
  stdout.write(":")
  color(fgGreen):
    stdout.write(minute)

when isMainModule:
  main()
