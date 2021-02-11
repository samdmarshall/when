
# =======
# Imports
# =======

import math
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
  let day_number = parseInt(day)
  let tens = floorDiv(day_number, 10)
  let remainder = floorMod(day_number, 10)
  case tens
  of 0, 2, 3:
    case remainder
    of 1:
      result = "st"
    of 2:
      result = "nd"
    of 3:
      result = "rd"
    else:
      result = "th"
  else:
    result = "th"

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
  # let era = local_time.format("g")

  let hour = local_time.format("HH")
  let minute = local_time.format("mm")

  commandline:
    option setColorFlag, string, "color", "c", "Auto"
    exitoption "help", "h", fmt"{NimblePkgName} [-h|--help] [-v|--version] [-c|--color:<Auto|Always|Never>]"
    exitoption "version", "v", fmt"{NimblePkgName} v{NimblePkgVersion}"

  let color_flag_value = capitalizeAscii(setColorFlag)
  var display_color = parseEnum[ColorFlagOptions](color_flag_value, Auto)
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
