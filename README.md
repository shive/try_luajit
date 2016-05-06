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

    real    0m21.483s
    user    0m0.000s
    sys     0m0.046s


luajit
------

http://luajit.org/download/LuaJIT-2.1.0-beta2.zip

lua同様に事前にバイトコンパイルしても速度は変わらなかったので普通に実行。

    $ bin/luajit2 -v
    LuaJIT 2.1.0-beta2 -- Copyright (C) 2005-2016 Mike Pall. http://luajit.org/

    $ time bin/luajit2 test/prime.lua 15000000
    14999981

    real    0m2.150s
    user    0m0.015s
    sys     0m0.031s

参考にバイトコンパイル方法。
binに移動しているのはjitフォルダを見つけられないとバイトコンパイルが行えないため。

    $ (cd bin && ./luajit2 -bs ../test/prime.lua ../test/prime.lua.out)
    $ time bin/luajit2 test/prime.lua.out 15000000
    14999981

    real    0m2.187s
    user    0m0.000s
    sys     0m0.046s


CPython
-------

64bit版のPython2.7.11で検証。
array.appendはlist.appendの倍くらい重い。剰余演算(%)は型が違うと重い。ゼロと比較するよりはnotを使う方が速い。

    $ C:/Python27/python -V
    Python 2.7.11

    $ time C:/Python27/python test/prime2.py 15000000
    14999981

    real    0m38.026s
    user    0m0.000s
    sys     0m0.047s

参考に64bit版のPython3.4でも検証。Python3の方が遅かった。

    $ C:/Python34/python -V
    Python 3.4.4

    $ time C:/Python34/python test/prime3.py 15000000
    14999981

    real    0m53.937s
    user    0m0.000s
    sys     0m0.046s

さらに64bit版のPython3.5。3.4よりちょっと速い。

    $ 'C:/Program Files/Python35/python' -V
    Python 3.5.1

    $ time 'C:/Program Files/Python35/python' test/prime3.py 15000000
    14999981

    real    0m50.572s
    user    0m0.000s
    sys     0m0.046s


IronPython
----------

http://ironpython.codeplex.com/releases/view/169382
http://ironpython.codeplex.com/downloads/get/970326

要zip展開。

    $ time IronPython-2.7.5/ipy64.exe 15000000
    14999981

    real    0m20.353s
    user    0m0.031s
    sys     0m0.000s

IronPythonは計算処理以前にexeの起動自体が若干重い。
CPythonと比べると10倍近い差がある。

    # time IronPython-2.7.5/ipy.exe test/prime2.py 5
    3

    real    0m1.374s
    user    0m0.000s
    sys     0m0.031s

    # time C:/Python27/python test/prime2.py 5
    3

    real    0m0.156s
    user    0m0.046s
    sys     0m0.000s


C#
--

    $ time bin/prime_cs 15000000
    14999981

    real    0m3.174s
    user    0m0.015s
    sys     0m0.031s


java
----

    $ java -version
    java version "1.8.0_92"
    Java(TM) SE Runtime Environment (build 1.8.0_92-b14)
    Java HotSpot(TM) 64-Bit Server VM (build 25.92-b14, mixed mode)

    $ (cd test && time java prime 15000000)
    14999981

    real    0m2.088s
    user    0m0.015s
    sys     0m0.015s


PyPy
----

https://bitbucket.org/pypy/pypy/downloads/pypy-5.1.0-win32.zip

PyPyは32bitで検証。要zip展開。

    $ pypy-5.1.0-win32/pypy -V
    Python 2.7.10 (3260adbeba4a, Apr 19 2016, 20:39:40)
    [PyPy 5.1.0 with MSC v.1500 32 bit]

    $ time pypy-5.1.0-win32/pypy test/prime2.py 15000000
    14999981

    real    0m2.808s
    user    0m0.015s
    sys     0m0.031s


Cython
------

Cythonで test/prime3.py をコンパイルしただけだと速度アップはこの程度。

    $ time bin/prime3_pyx 15000000
    14999981

    real    0m29.825s
    user    0m0.000s
    sys     0m0.046s

そこからCython向けに最適化を施すと爆速になる。

    $ python -V
    Python 3.4.4

    $ python -m cython --version
    Cython version 0.24

    $ time bin/prime_pyx 15000000
    14999981

    real    0m2.059s
    user    0m0.000s
    sys     0m0.062s


C++
---

    $ time bin/prime_cpp 15000000
    14999981

    real    0m1.658s
    user    0m0.015s
    sys     0m0.031s


C言語
-----

やっぱりこれが最速。

    $ time bin/prime_c 15000000
    14999981

    real    0m1.564s
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

    real    0m3.330s
    user    0m0.015s
    sys     0m0.031s


golang
------

https://storage.googleapis.com/golang/go1.6.2.windows-amd64.zip

事前コンパイル系にしてはだいぶ遅いが、これは習熟度の問題のような気もする。

    $ go version
    go version go1.6.2 windows/amd64

    $ time go run test/prime.go 15000000
    14999981

    real    0m5.192s
    user    0m0.000s
    sys     0m0.046s


まとめ
------

C言語 >>> C++ >>> Cython >>> java >>> luajit >>> PyPy >>> C# >>> node.js >>> golang >>> （越えられない壁） >>> IronPython >>> lua >>> Python2 >>> Python3

CFFIやpyximportも試してみたらいいかもしれないが、実行時にコンパイラが必要になるのでイマイチ。

サクサク作りたいツール類は Python2/3 で大枠を作り、速度が欲しいところだけ Cython で高速化。
インゲームスクリプトなどリアルタイム性の必要なものは luajit が最適。

