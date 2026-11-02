# NXD Language Extension

Editor tooling for the **NXD programming language**, including the VS Code extension and the NXD language-server/diagnostic 
integration.

This repository is intentionally separate from the core [`nxd_language`](https://github.com/GTS-AppliedTech/nxd_language) 
compiler repository so editor tooling can evolve independently while continuing to use the compiler as the authoritative 
implementation of NXD syntax and semantics.

## Project Scope

This repository contains the editor-facing components of NXD tooling, including:

- VS Code extension integration
- NXD syntax highlighting and language configuration
- File icons and extension assets
- LSP/parser bridge code
- Prebuilt extension-side binaries where required for distribution
- Extension packaging and release configuration

The core compiler, parser, semantic analysis, IR, diagnostics, and backend implementation remain in the `nxd_language` repository.

---

## Relationship to `nxd_language`

The extension does not define NXD language semantics independently. Rust tooling in this repository consumes functionality exposed
by the `nxd_language` crate so that editor diagnostics remain aligned with the compiler.

Conceptually:

```
nxd_language
    |
    | compiler/parser/diagnostic APIs
    v
nxdlang-extension
    |
    | editor integration
    v
VS Code
```

The resulting extension-side binaries should be distributable without requiring extension users to separately clone the
`nxd_language` source repository.

---

## Repository Layout

The exact layout may evolve as the repository is separated from the compiler, but the extension currently includes components 
such as:

```
nxdlang-extension/
|-- LSP-test.nxd
|-- NXD/
|   |-- bin/
|   |-- fileicons/
|   |-- images/
|   |-- syntaxes/
|   |-- .vscodeignore
|   |-- CHANGELOG.md
|   |-- LICENSE.md
|   |-- README.md
|   |-- extension.js
|   |-- language-configuration.json
|   |-- lsp_parser.rs
|   |-- package.json
|   `-- vsc-extension-quickstart.md
|-- README.md
`-- CONTRIBUTING.md
```
---

## Building

Development of the Rust-side tooling requires access to the `nxd_language` crate. During local development, the repositories can 
be kept next to one another and the dependency can be configured as a local path dependency.

For example:

```
Projects/
|-- nxd_language/
`-- nxdlang-extension/
```

A local development dependency may then use:

```toml
nxd_language = { path = "../nxd_language" }
```

For reproducible release builds, the dependency should instead be pinned to an appropriate published version, Git tag, or commit
once that release workflow is established.

---

## Extension Packages

Generated `.vsix` packages are build artifacts and should not normally be committed to the repository. Published packages and 
release binaries should be distributed through the project's chosen release channels.

---

## Contributing

Contributions to the NXD editor tooling are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for repository scope, development 
expectations, testing guidance, and contribution workflow.

For changes to NXD itself, including grammar, compiler semantics, IR behavior, diagnostics, and backend behavior, use the
[`nxd_language`](https://github.com/GTS-AppliedTech/nxd_language) repository instead.

---

## License

NXD Language Extension is licensed under the [MIT License](LICENSE.md). See the repository's license file for details.

---

## Author

Created and maintained by Gabriel Ty Spencer / GTS Applied Technology.
