#!/bin/env python
# -*- mode: python; coding: utf-8-sig -*-
#=======================================================================================================================
__author__ = 'hshibuya <goe@fuzz.co.jp>'

import os


### ビルドの共通設定
env_base = Environment(
    TARGET_ARCH = 'x86_64',
    TEMP = os.environ['TEMP'],
    PYTHON3 = File('C:/Python34/python.exe'),
    # CSC = Glob(os.path.expandvars(r'${ProgramFiles(x86)}/MSBuild/*/Bin/amd64/csc.exe'))[-1],
    CSC = Glob(os.path.expandvars(r'C:/Windows/Microsoft.NET/Framework64/v*/csc.exe'))[-1],
    )
env_base.AppendUnique(
    CPPDEFINES = [
        '_MBCS', '_WIN32', 'WIN32', '_DLL', 'NDEBUG',
        '_WIN32_WINNT=0x0601', '_CRT_SECURE_NO_WARNINGS', '_SCL_SECURE_NO_WARNINGS',
        ],
    CPPPATH = [
        Dir('C:/Python34/include'),
        ],
    LIBPATH = [
        Dir('C:/Python34/libs'),
        ],
    CCFLAGS = [
        '/MD',          # ランタイムを動的リンク
        '/EHa',         # 例外を有効にする
        '/GR-',         # RTTIを無効にする

        '/Oi',          # 組み込み関数を有効にする
        '/MP',          # 複数プロセッサによるコンパイル
        '/GF',          # 文字列プール：はい
        '/Gm-',         # 最小リビルドを有効にする：いいえ
        '/Gy',          # 関数レベルでリンクする：はい
        '/Gd',          # 呼び出し規約：__cdecl
        '/fp:fast',     # 浮動小数点モデル：Fast
        '/fp:except-',  # 浮動小数点の例外を有効にする：いいえ
        '/Zc:wchar_t',  # wchar_t をビルトイン型として扱う
        '/Zc:forScope', # forループスコープの強制準拠
        '/FC',          # 完全パスの使用
        '/Zm150',       # プリコンパイル済みヘッダーのメモリ割り当て制限の指定 100=50MB から 2000=100*20=50*20MB=1000MB まで
        '/FS',          # 複数のcl.exeが同時に.pdbへ書き込む
        '/GS',          # バッファオーバーランによるセキュリティ脆弱性のチェック

        '/O2',          # 最適化
        '/GL',          # リンク時コード生成
        ],
    LINKFLAGS = [
        '/LTCG',        # リンク時コード生成
        ],
    LIBS = [
        'kernel32', 'user32', 'gdi32', 'winspool', 'comdlg32', 'advapi32', 'shell32',
        'ole32', 'oleaut32', 'uuid', 'odbc32', 'odbccp32', 'opengl32',
        'ws2_32', 'winmm', 'd3d11', 'dxgi', 'd3dcompiler', 'dxguid',
        ],
    )
out_dir = env_base.Dir('bin')
env_base.Default(out_dir)


# ### lua51.dll
# env = env_base.Clone()
# env.AppendUnique(
#     CPPDEFINES = [
#         'LUA_BUILD_AS_DLL',
#         ],
#     )
# env.VariantDir(env.Dir('$TEMP/lua51_dll'), env.Dir('lua-5.1.4/src'), duplicate=0)
# lua51_sources = env.Glob('$TEMP/lua51_dll/*.c')
# lua51_sources.remove(env.File('$TEMP/lua51_dll/luac.c'))
# lua51_sources.remove(env.File('$TEMP/lua51_dll/lua.c'))
# env.CopyAs('bin/lua51.dll', env.SharedLibrary('$TEMP/lua51_dll/lua51.dll', lua51_sources)[0])
# del env


# lua
env = env_base.Clone()
env.VariantDir(env.Dir('$TEMP/lua_exe'), env.Dir('lua-5.1.4/src'), duplicate=0)
lua51_sources = env.Glob('$TEMP/lua_exe/*.c')
lua51_sources.remove(env.File('$TEMP/lua_exe/luac.c'))
env.CopyAs(out_dir.File('lua.exe'), env.Program('$TEMP/lua_exe/lua.exe', lua51_sources))
del env


### luac
env = env_base.Clone()
env.VariantDir(env.Dir('$TEMP/luac_exe'), env.Dir('lua-5.1.4/src'), duplicate=0)
lua51_sources = env.Glob('$TEMP/luac_exe/*.c')
lua51_sources.remove(env.File('$TEMP/luac_exe/lua.c'))
env.CopyAs(out_dir.File('luac.exe'), env.Program('$TEMP/luac_exe/luac.exe', lua51_sources))
del env


### luajit
env = env_base.Clone()
luajit2_exe, luajit2_dll = env.Command(['LuaJIT-2.1.0-beta2/src/luajit.exe', 'LuaJIT-2.1.0-beta2/src/lua51.dll'], None,
                                       '@echo off && call msvcbuild.bat', chdir='LuaJIT-2.1.0-beta2/src')
env.CopyAs(out_dir.File('luajit2.exe'), luajit2_exe)
env.Depends(out_dir.File('luajit2.exe'), env.CopyAs(out_dir.File('lua51.dll'), luajit2_dll))
env.Depends(out_dir.File('luajit2.exe'), [env.CopyAs(out_dir.Dir('jit').File(s.name), s) for s in env.Glob('LuaJIT-2.1.0-beta2/src/jit/*')])
del env


### prime_c.exe
env = env_base.Clone()
env.VariantDir(env.Dir('$TEMP/prime_c'), env.Dir('test'), duplicate=0)
env.CopyAs(out_dir.File('prime_c.exe'), env.Program(env.File('$TEMP/prime_c/prime.c')))
del env


### prime_cpp.exe
env = env_base.Clone()
env.VariantDir(env.Dir('$TEMP/prime_cpp'), env.Dir('test'), duplicate=0)
env.CopyAs(out_dir.File('prime_cpp.exe'), env.Program(env.File('$TEMP/prime_cpp/prime.cpp')))
del env


### prime_pyx.pyd
env = env_base.Clone()
env.VariantDir(env.Dir('$TEMP/prime_pyx'), env.Dir('test'), duplicate=0)
env.Command('$TEMP/prime_pyx/prime_pyx.cpp', 'test/prime.pyx', '$PYTHON3 -m cython --cplus --embed -3 -o ${TARGET.abspath} ${SOURCE.abspath}')
env.CopyAs(out_dir.File('prime_pyx.exe'), env.Program('$TEMP/prime_pyx/prime_pyx.cpp'))
del env


### prime_cs.exe
env = env_base.Clone()
env.Command('bin/prime_cs.exe', 'test/prime.cs', '$CSC /nologo /target:exe /out:$TARGET $SOURCE')
del env
