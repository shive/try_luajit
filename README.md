luajit vs pypy
==============

検証マシン
----------

os: Windows 8.1 64bit
cpu: i7-4870HQ / 2.50GHz / 8CPUs


lua
---

バージョンはluajitと揃えた。自前でVisualStudio2015で64bitビルドしたもの。
.luaは事前にバイトコンパイルしても速度は変わらなかった。

  $ bin/lua -v
  Lua 5.1.4  Copyright (C) 1994-2008 Lua.org, PUC-Rio

  $ time bin/lua test/prime.lua 15000000
  14999981

  real    0m26.853s
  user    0m0.000s
  sys     0m0.031s


luajit
------

lua同様に事前にバイトコンパイルしても速度は変わらなかった。

  $ bin/luajit2 -v
  LuaJIT 2.1.0-beta2 -- Copyright (C) 2005-2016 Mike Pall. http://luajit.org/

  $ time bin/luajit2 test/prime.lua 15000000
  14999981

  real    0m2.547s
  user    0m0.000s
  sys     0m0.015s


CPython
-------

64bit版のPython2.7.11で検証。

  $ C:/Python27/python -V
  Python 2.7.11

  $ time C:/Python27/python test/prime.py 15000000
  14999981

  real    0m39.280s
  user    0m0.000s
  sys     0m0.031s

参考に64bit版のPython3.4.4でも検証。Python3の方が遅い。

  $ C:/Python34/python -V
  Python 3.4.4

  $ time C:/Python34/python test/prime3.py 15000000
  14999981

  real    1m41.368s
  user    0m0.015s
  sys     0m0.031s


PyPy
----

