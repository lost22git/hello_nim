import iterrr

#[

  [iterrr](https://github.com/hamidb80/iterrr)

  `nimble install iterrr`

]#

echo "count: ", (1..10) |> count()
echo "sum: ", (1..10) |> sum()
echo "min: ", (1..10) |> min()
echo "max: ", (1..10) |> max()
echo "first: ", (1..10) |> first()
echo "last: ", (1..10) |> last()
echo "strjoin: ", (1..10) |> strjoin(";")

(1..10) |> filter(it <= 3).each(v):
  echo "each: ", v

echo "filter map: ", (1..10) |> filter(it <= 3).map(it * it).toSeq()

echo "breakif: ", (1..10) |> breakif(it > 3).toSeq()

echo "drop take: ", (1..10) |> drop(3).take(3).toSeq()

echo "group: ", (1..10) |> group(3).toSeq()

import std/deques
echo "window: ", (1..10) |> window(3).toSeq()

import std/sequtils
echo "no flatten: ", (1..10) |> filter(it < 3).map((it..(it * 2)).toSeq()).toSeq()
echo "flatten: ",
  (1..10) |> filter(it < 3).map((it..(it * 2)).toSeq()).flatten().toSeq()
