# Test to execute clang as a subprocess in a Lean program

This is a very small program written in [Lean][1] which only spawns [clang][2] as a subprocess and prints it stdout, stderr and exit code.
I get a very strange output on my machine signifying that [clang][2] cannot find its shared libraries (.so-files).
Note that I'm talking about the .so files that the clang executable needs to run and not anything else.
The fact that [clang][2] is a compiler is just a coincidence.

I consider this to be a bug in Lean's "spawn-subprocess-functionality" and would be happy if someone could fix it or explain why so is not the case.

## Running

You need to install the Lean build system [Lake][3].
Then run (from the repository root):

```Bash
$ lake exe lean_clang_test
Stdout:
Stderr: clang: symbol lookup error: clang: undefined symbol: LLVMInitializeHexagonAsmParser, version LLVM_15
Exit code: 127
```

That is at least the output I get on my machine.
I have no problems running clang as a normal command in the shell, so I think something is wrong with Lean's subprocess spawning function.

## Code

All the relevant code can be found in `Main.lean`.
It is just 5 lines, so I'll paste it here:

```
def main : IO Unit := do
  let res ← IO.Process.output { cmd := "clang" }
  IO.println s!"Stdout: {res.stdout}"
  IO.println s!"Stderr: {res.stderr}"
  IO.println s!"Exit code: {res.exitCode}"
```

## Background

I found this when I was trying to compile some C++ bindings in a Lean library.
First I compiled them with GCC, but due to ABI compatability issues between libstdc++ and libc++ I tried to switch to Clang.
However, then I got this strange error which was very frustrating and took half a night to debug :)



[1]: https://leanprover.github.io/about/
[2]: https://clang.llvm.org
[3]: https://github.com/leanprover/lake
