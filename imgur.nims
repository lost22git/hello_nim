#[
///usr/bin/env nim --hints:off "$0" "$@" ; exit $?
]#

#[ 
  Flags:
     -d:verbose 
     -d:json

  Usage:
    > ./imgur.nims 1.jpg

    > nim --hints:off -d:verbose -d:json ./imgur.nims 1.jpg
]#

import std/[strformat, json]

const uri = "https://api.imgur.com/3/image?client_id=546c25a59c58ad7"

proc upload(
    filePath: string = paramStr(paramCount()), proxy = getEnv("HTTPS_PROXY", "")
): string =
  let cmd =
    if proxy == "":
      fmt"""curl -sS -X POST {uri} -H "Referer: https://imgur.com/" -F image="@{filePath}""""
    else:
      fmt"""curl -sS -X POST {uri} -x {proxy} -H "Referer: https://imgur.com/" -F image="@{filePath}""""
  when defined(verbose):
    echo "Run cmd: ", cmd
  let (output, code) = gorgeEx cmd
  when defined(verbose):
    echo "Run cmd output: ", output
  if code == 0:
    return output
  else:
    raise newException(IOError, output)

let uploadResult = upload()
echo ""
when defined(json):
  echo uploadResult.parseJson().pretty()
else:
  echo "Link: ", uploadResult.parseJson()["data"]["link"].getStr("")
