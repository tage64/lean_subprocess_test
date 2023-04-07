def main : IO Unit := do
  let res ← IO.Process.output { cmd := "clang" }
  IO.println s!"Stdout: {res.stdout}"
  IO.println s!"Stderr: {res.stderr}"
  IO.println s!"Exit code: {res.exitCode}"
