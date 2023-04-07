import Lake
open Lake DSL

package «lean_clang_test» {
  precompileModules := true
}

lean_lib «LeanClangTest»

@[default_target]
lean_exe «lean_clang_test» {
  root := `Main
}
