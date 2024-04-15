#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

import std/logging

# | Variable | Output                    |
# |----------|---------------------------|
# |$date     | Current date              |
# |$time     | Current time              |
# |$datetime | $dateT$time               |
# |$app      | os.getAppFilename()       |
# |$appname  | Base name of $app         |
# |$appdir   | Directory name of $app    |
# |$levelid  | First letter of log level |
# |$levelname| Log level name            |

# | level enum |
# |------------|
# |lvlAll      |
# |lvlDebug    |
# |lvlInfo     |
# |lvlNotice   |
# |lvlWarn     |
# |lvlError    |
# |lvlFatal    |
# |lvlNone     |

let globalLogger = newConsoleLogger(
  fmtStr = "$datetime $levelname <$appname> - ",
  # fmtStr = verboseFmtStr,
  levelThreshold = lvlAll,
)

addHandler(globalLogger)

debug("a message", "for debug")
info("a message", "for info")
notice("a message", "for notice")
warn("a message", "for warn")
error("a message", "for error")
fatal("a message", "for fatal")

let localLogger = newConsoleLogger(fmtStr = "$datetime $levelname <local_logger>  - ")

localLogger.log(lvlDebug, "a message", "for debug")
localLogger.log(lvlInfo, "a message", "for info")
localLogger.log(lvlNotice, "a message", "for notice")
localLogger.log(lvlWarn, "a message", "for warn")
localLogger.log(lvlError, "a message", "for error")
localLogger.log(lvlFatal, "a message", "for fatal")
