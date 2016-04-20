#!/bin/env python
# -*- mode: python; coding: utf-8-sig -*-
#=======================================================================================================================
__author__ = 'hshibuya <goe@fuzz.co.jp>'

import os


### ビルドの共通設定
env_base = Environment(
    TARGET_ARCH = 'x86_64',
    TEMP = os.environ['TEMP'],
    )
env_base.AppendUnique(
    CPPDEFINES = [
        '_MBCS', '_WIN32', 'WIN32', '_DLL', 'NDEBUG',
        '_WIN32_WINNT=0x0601', '_CRT_SECURE_NO_WARNINGS', '_SCL_SECURE_NO_WARNINGS',
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


### luaのビルド
env = env_base.Clone()
env.AppendUnique(
    CPPDEFINES = [
        'LUA_BUILD_AS_DLL',
        ],
    )
env.VariantDir(env.Dir('$TEMP/lua51_dll'), env.Dir('lua-5.1.4/src'), duplicate=0)
lua_sources = env.Glob('$TEMP/lua51_dll/*.c')
lua_sources.remove(env.File('$TEMP/lua51_dll/luac.c'))
lua_sources.remove(env.File('$TEMP/lua51_dll/lua.c'))
env.CopyAs('bin/lua51.dll', env.SharedLibrary('$TEMP/lua51_dll/lua51.dll', lua_sources)[0])
del env

env = env_base.Clone()
env.VariantDir(env.Dir('$TEMP/lua_exe'), env.Dir('lua-5.1.4/src'), duplicate=0)
lua_sources = env.Glob('$TEMP/lua_exe/*.c')
lua_sources.remove(env.File('$TEMP/lua_exe/luac.c'))
lua_sources.remove(env.File('$TEMP/lua_exe/lua.c'))
env.CopyAs('bin/luac.exe', env.Program('$TEMP/lua_exe/luac.exe', [env.File('$TEMP/lua_exe/luac.c')] + lua_sources))
env.CopyAs('bin/lua.exe', env.Program('$TEMP/lua_exe/lua.exe', [env.File('$TEMP/lua_exe/lua.c')] + lua_sources))
del env

