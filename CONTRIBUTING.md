# Contributing to NXD Language Extension

Thank you for your interest in contributing to the NXD editor tooling. This repository is focused on the extension and
language-server integration around NXD, while the `nxd_language` repository remains the authoritative implementation of the 
language itself.
Keeping that boundary clear makes both projects easier to understand, test, and maintain.

---

## What Belongs in This Repository

Changes are appropriate here when they concern editor-facing NXD tooling, including:

- VS Code extension behavior
- Language-server integration
- Diagnostic presentation in the editor
- Syntax-highlighting definitions
- Language configuration
- File icons and extension assets
- Extension packaging
- Extension-side Rust bridge code
- Platform-specific extension binary packaging
- Tests specifically covering editor/LSP behavior

---

## What Belongs in `nxd_language`

Changes to the language itself should be made in the core repository instead. Examples include:

- NXD grammar or syntax
- Parser behavior
- AST definitions
- IR definitions or lowering
- Semantic analysis
- Compiler diagnostic definitions
- Warning rules
- Runtime/compiler behavior
- Nim, D, Elixir, or other compiler backends

The extension should consume compiler behavior rather than redefine it.

---

## Development Setup

A convenient local layout is:

```
Projects/
|-- nxd_language/
`-- nxdlang-extension/
```

During simultaneous compiler and extension development, the extension-side Rust package can reference the compiler with a local Cargo dependency:

```toml
nxd_language = { path = "../nxd_language" }
```

Do not commit machine-specific absolute paths.

Before submitting a change, make sure dependencies install successfully and that the components affected by your change build
cleanly.

---

## Keep Changes Focused

Prefer small contributions with one clear purpose. For example:

- fix one syntax-highlighting issue
- correct one extension behavior
- improve one diagnostic mapping
- add support for one editor-facing language feature
- update one documented workflow

Avoid mixing compiler-language changes and extension changes into a single extension pull request. When a feature requires changes
in both repositories, keep the commits and pull requests independently understandable and explicitly describe the dependency 
between them.

---

## Diagnostics and Language Semantics

The `nxd_language` compiler is authoritative for NXD parsing, semantic behavior, diagnostic codes, spans, and messages.

Extension code may adapt compiler output for editor presentation, but should not silently create a second implementation of NXD 
semantics.

If an editor diagnostic is incorrect because the compiler reports incorrect information, fix the underlying behavior in
`nxd_language` first.

If the compiler output is correct but it is displayed incorrectly by the extension, the fix belongs here.

---

## Testing

Test the smallest relevant surface first, then verify the complete affected workflow.

Depending on the change, this may include:

1. Building the Rust-side LSP/diagnostic executable.
2. Running an NXD source fixture through the executable.
3. Confirming diagnostic JSON/output is correct.
4. Running the extension in a VS Code development host.
5. Opening representative `.nxd` files and verifying the affected editor behavior.
6. Packaging the extension when the change affects distribution or packaged resources.

`LSP-test.nxd` may be used for manual LSP-focused testing where appropriate. Additional regression fixtures are encouraged when
a bug can be represented with a small repeatable NXD source file.

## Generated Files and Build Artifacts

Do not commit generated or machine-local artifacts unless the repository's distribution design explicitly requires them.

In particular, avoid committing:

- `target/`
- `node_modules/`
- `.vsix` packages
- temporary files
- editor caches
- log files

Prebuilt runtime binaries are a special case because they may be required by packaged versions of the extension. Changes to
tracked binaries should correspond to intentional source changes and should not replace source-level review.

---

## Pull Requests

A pull request should clearly explain:

- what changed
- why the change is needed
- which extension/LSP behavior is affected
- how the change was tested
- whether it depends on a particular `nxd_language` change or version

When fixing a bug, include a minimal reproduction or test case whenever practical.

---

## Commit Hygiene

Keep commits scoped and descriptive. Avoid bundling unrelated formatting, generated packages, dependency changes, and functional
changes into one commit when they can reasonably be separated.

This is especially important when a change crosses the boundary between `nxd_language` and `nxdlang-extension`: each repository 
should retain a useful rollback point of its own.

---

## Documentation

Update relevant documentation when a contribution changes:

- user-visible extension behavior
- installation or packaging
- supported editor features
- development/build instructions
- the dependency relationship with `nxd_language`

Keep documentation aligned with implemented behavior rather than planned behavior.

---

## Reporting Issues

When reporting an extension or LSP issue, include enough information to reproduce the problem where possible:

- the NXD source that triggers the issue
- expected behavior
- actual behavior
- relevant diagnostic code/message
- operating system
- VS Code/extension context when relevant

For a compiler or language-semantics problem, report the issue against `nxd_language` instead.

---

## License

By contributing, you agree that your contributions will be made available under the repository's [MIT License](LICENSE.md).
