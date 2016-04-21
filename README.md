luajit vs pypy
==============

検証マシン
----------

 * os: Windows 8.1 64bit
 * cpu: i7-4870HQ / 2.50GHz / 8CPUs


lua
---

https://www.lua.org/ftp/lua-5.1.4.tar.gz

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

http://luajit.org/download/LuaJIT-2.0.4.zip

lua同様に事前にバイトコンパイルしても速度は変わらなかったので普通に実行。

    $ bin/luajit2 -v
    LuaJIT 2.1.0-beta2 -- Copyright (C) 2005-2016 Mike Pall. http://luajit.org/

    $ time bin/luajit2 test/prime.lua 15000000
    14999981

    real    0m2.547s
    user    0m0.000s
    sys     0m0.015s

参考にバイトコンパイル方法。
binに移動しているのはjitフォルダを見つけられないとバイトコンパイルが行えないため。

    $ (cd bin && ./luajit2 -bs ../test/prime.lua ../test/prime.lua.out)
    $ time bin/luajit2 test/prime.lua.out 15000000
    14999981

    real    0m2.540s
    user    0m0.000s
    sys     0m0.046s


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

参考に64bit版のPython3.4.4でも検証。Python3の方が遅かった。

    $ C:/Python34/python -V
    Python 3.4.4

    $ time C:/Python34/python test/prime3.py 15000000
    14999981

    real    1m41.368s
    user    0m0.015s
    sys     0m0.031s


PyPy
----

https://bitbucket.org/pypy/pypy/downloads/pypy-5.1.0-win32.zip

PyPyは32bitで検証。こいつだけzipの展開が必要。

    $ pypy-5.1.0-win32/pypy -V
    Python 2.7.10 (3260adbeba4a, Apr 19 2016, 20:39:40)
    [PyPy 5.1.0 with MSC v.1500 32 bit]

    $ time pypy-5.1.0-win32/pypy test/prime.py 15000000
    14999981

    real    0m2.873s
    user    0m0.031s
    sys     0m0.015s


Cython
------

Cythonもかなり高速。

    $ python -V
    Python 3.4.4

    $ python -m cython --version
    Cython version 0.24b0

    $ time bin/prime_pyx 15000000
    14999981

    real    0m2.085s
    user    0m0.015s
    sys     0m0.046s


C言語
-----

やっぱりこれが最速。

    $ time bin/prime_c 15000000
    14999981

    real    0m0.144s
    user    0m0.015s
    sys     0m0.031s


node.js
-------

https://nodejs.org/dist/v5.10.1/win-x64/node.exe

JavaScriptでも検証してみた。インタプリタほどではないがjit系の中では遅いという結果。

    $ bin/node -v
    v5.10.1

    $ time bin/node test/prime.js 15000000
    14999981

    real    0m3.763s
    user    0m0.000s
    sys     0m0.046s


まとめ
------

C言語 >>> Cython >>> luajit >>> PyPy >>> node.js >>> （越えられない壁） >>> lua >>> Python2 >>> Python3

CFFIやpyximportも試してみたらいいかもしれないが、実行時にコンパイラが必要になるのでイマイチ。

がっつり Python2/3 で作っているところで部分的に速くするなら Cython で特定の一部モジュールを高速化して、
インゲームスクリプトなどリアルタイム性の必要なものは luajit が最適。

