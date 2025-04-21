---
title: "Rust, Test Coverage, and You"
date: 2025-04-20T12:00:00-06:00
draft: false
tags: ["rust", "testing", "nix"]
downloads: []
blog: true
---

Like so many aspects of CI, test coverage reporting is something that really ought to be set-it-and-forget-it. Of course, "forget it" inevitably comes to bite you in the ass unless you write the details down somewhere.

This post is not intended to be a comprehensive guide to configuring test coverage. Instead, it's a reminder to myself of various extremely similarly named test coverage tools, both within Rust and in the wider programming ecosystem.

## Tools

- [Gcov](https://gcc.gnu.org/onlinedocs/gcc/Gcov.html)
  - **Instrumentation** - GNU's general-purpose, multi-language test coverage tool. Only works on code compiled with GCC.
- [LCOV](https://github.com/linux-test-project/lcov)
  - **Reporting** - A set of Perl scripts for reporting on the output from instrumentation tools like Gcov, llvm-cov, and so on. Scripts include `genhtml` for creating HTML reports, `genpng` for create PNG reports, and so on.
- [Gcovr](https://gcovr.com/en/stable/)
  - **Instrumentation and reporting** - Gcovr is a Python-based wrapper that runs Gcov for you and implements its own reporting.
- [llvm-cov](https://llvm.org/docs/CommandGuide/llvm-cov.html)
  - **Reporting** - LLVM's first-party tool for showing test coverage information for instrumented programs that compile to LLVM. It has multiple subcommands: `gcov`, `show`, `report`, and `export`.
- [cargo-llvm-cov](https://github.com/taiki-e/cargo-llvm-cov)
  - **Instrumentation and reporting** - `cargo-llvm-cov` is a Rust package that adds an `llvm-cov` subcommand to Cargo. It wraps around rustc's built-in coverage tooling (`-C instrument-coverage`) and both generates coverage data as well as reports.
- [Rust instrument-coverage](https://doc.rust-lang.org/rustc/instrument-coverage.html)
  -  **Instrumentation** - Uses LLVM's native coverage tooling (`llvm-profdata` and `llvm-cov`) to provide Rust-native test coverage support.
- [Tarpaulin](https://github.com/xd009642/tarpaulin)
  - **Instrumentation and reporting** - This is a third-party coverage tool that uses Ptrace as its backend. As far as I can see, users should not be adopting Tarpaulin in new projects, as it has been superseded by Rust's native coverage support (`instrument-coverage`).

  ## My Approach

  I'm a beginner to this, so take my advice with a heaping spoonful of salt. My current solution is to use a combination of `crane`, `fenix`, and `cargo-llvm-cov` in a Nix flake. With Fenix, I can build a custom Rust toolchain like so:

  ```nix
  toolchain = fenix.packages.${system}.complete.withComponents [
    "cargo"
    "llvm-tools"
    "rustc"
  ];
  ```

  Then, I use that toolchain to build a coverage report in LCOV format via Crane:

  ```nix
  packages.x86_64-linux.lcov = craneLibLLvmTools.cargoLlvmCov {
    src = craneLib.cleanCargoSource ./.;
    inherit src;
    cargoArtifacts = craneLib.buildDepsOnly {
      src = craneLib.cleanCargoSource ./.;
    };
  };
  ```

  Now, if I run `nix build .#lcov`, Nix will spit out a symlink to my LCOV report at `./result`. However, what I really want is an HTML report. Unfortunately it seems that you can't get Crane to build an HTML report directly, because `cargo-llvm-cov`'s HTML generation doesn't support output redirection to Nix's magic `$out` environment variable. So instead, I am invoking my custom Cargo toolchain directly with a Flake app:

  ```nix
  apps.x86_64-linux.coverage = {
    type = "app";
    program = lib.getExe (pkgs.writeShellScriptBin "coverage" ''
      ${toolchain}/bin/cargo llvm-cov --open
    '');
  };
  ```

  Just run `nix run .#coverage`! The `--open` flag generates an HTML report at `./target/llvm-cov/html/index.html` and then opens the report in your browser of choice. You could use `--html` instead to just generate the report for CI purposes.

  You can see a full example of this solution [here](https://github.com/ciarandg/trowel/blob/fd04dddef5a346eb231d66d660eadd2bde1b1296/flake.nix).
