discard """
  output: '''4
0
4
4
1
2
3
yes int'''
  joinable: false
"""

import hashes

type
  Comparable = concept # no T, an atom
    proc cmp(a, b: Self): int

  ToStringable = concept
    proc `$`(a: Self): string

  Hashable = concept
    proc hash(x: Self): int
    proc `==`(x, y: Self): bool

  Swapable = concept
    proc swap(x, y: var Self)


proc h(x: Hashable) =
  echo x

h(4)

when true:
  proc compare(a: Comparable) =
    echo cmp(a, a)

  compare(4)

proc dollar(x: ToStringable) =
  echo x

when true:
  dollar 4
  dollar "4"

#type D = distinct int

#dollar D(4)

when true:
  type
    Iterable[Ix] = concept
      iterator items(c: Self): Ix

  proc g[Tu](it: Iterable[Tu]) =
    for x in it:
      echo x

  g(@[1, 2, 3])

proc hs(x: Swapable) =
  var y = x
  swap y, y

hs(4)

type
  Indexable[T] = concept # has a T, a collection
    proc `[]`(a: Self; index: int): T # we need to describe how to infer 'T'
    # and then we can use the 'T' and it must match:
    proc `[]=`(a: var Self; index: int; value: T)
    proc len(a: Self): int

proc indexOf[T](a: Indexable[T]; value: T) =
  echo "yes ", T

block:
  var x = @[1, 2, 3]
  indexOf(x, 4)
