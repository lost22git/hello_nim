#[
///usr/bin/env nim r -d:ssl "$0" "$@" ; exit $?
]#

import std/[httpclient, asyncdispatch, strformat, os, json, logging]

proc doPost(): Future[string] {.async.} =
  const base_uri = "https://httpbin.org"

  var client = newAsyncHttpClient()
  let response = await client.request(
    url = base_uri & "/post",
    httpmethod = HttpPost,
    headers = newHttpHeaders({"Content-Type": "application/json"}),
    body = """{"msg":"hello nim"}""",
  )
  let content = await response.body()
  debug("Got content:", content)
  return $parseJson(content)["data"]

addHandler newConsoleLogger(fmtStr = "$datetime $levelname | ", levelThreshold = lvlAll)

try:
  info("Got data=", waitfor doPost())
except:
  error("Error: ", getCurrentExceptionMsg())
