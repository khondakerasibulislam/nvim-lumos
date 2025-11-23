# nvim-lumos

Neovim plugin for LUMOS schema language with Tree-sitter syntax highlighting and LSP support.

## Features

- **Syntax Highlighting**: Full Tree-sitter grammar for `.lumos` files
- **LSP Integration**: Auto-completion, diagnostics, hover, and more via `lumos-lsp`
- **Smart Keybindings**: Pre-configured keymaps for common LSP operations
- **Formatting**: Format on save support

## Prerequisites

1. **Neovim 0.9+** (for Tree-sitter and LSP support)
2. **lumos-lsp**: LUMOS Language Server
   ```bash
   cargo install lumos-lsp
   ```
3. **nvim-treesitter**: Tree-sitter integration for Neovim
4. **nvim-lspconfig**: LSP configuration framework

## Installation

### Using lazy.nvim

```lua
{
  "getlumos/nvim-lumos",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("lumos").setup()
  end,
}
```

### Using packer.nvim

```lua
use {
  "getlumos/nvim-lumos",
  requires = {
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("lumos").setup()
  end,
}
```

### Manual Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/getlumos/nvim-lumos ~/.local/share/nvim/site/pack/lumos/start/nvim-lumos
   ```

2. Install Tree-sitter parser:
   ```bash
   cd ~/.local/share/nvim/site/pack/lumos/start/nvim-lumos
   git clone https://github.com/getlumos/tree-sitter-lumos
   ```

3. Add to your `init.lua`:
   ```lua
   require("lumos").setup()
   ```

## Configuration

### Basic Setup

```lua
require("lumos").setup()
```

### Custom Configuration

```lua
require("lumos").setup({
  -- Custom options (currently none, reserved for future)
})
```

### Tree-sitter Setup (Optional)

If you want to manually configure Tree-sitter:

```lua
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lumos" },
  highlight = {
    enable = true,
  },
})
```

### LSP Custom Configuration

To customize LSP behavior:

```lua
local lspconfig = require("lspconfig")

lspconfig.lumos.setup({
  on_attach = function(client, bufnr)
    -- Your custom on_attach logic
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
```

## Default Keybindings

These keybindings are automatically set up for `.lumos` files:

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `K` | Normal | Show hover documentation |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code actions |
| `gr` | Normal | Find references |
| `<leader>f` | Normal | Format document |

## File Structure

```
nvim-lumos/
├── ftdetect/
│   └── lumos.lua          # File type detection for .lumos files
├── lua/
│   └── lumos/
│       ├── init.lua       # Main plugin entry point
│       └── lsp.lua        # LSP configuration
├── queries/
│   └── lumos/
│       └── highlights.scm # Syntax highlighting queries
├── LICENSE-MIT
├── LICENSE-APACHE
└── README.md
```

## Supported Syntax

The plugin provides syntax highlighting and LSP support for:

- **Structs**: `struct Player { ... }`
- **Enums**: `enum GameState { ... }`
- **Attributes**: `#[solana]`, `#[account]`, `#[deprecated]`
- **Types**:
  - Primitives: `u8`, `u16`, `u32`, `u64`, `u128`, `i8`, `i16`, `i32`, `i64`, `i128`, `bool`, `String`
  - Solana: `PublicKey`, `Signature`
  - Collections: `Vec<T>`, `Option<T>`, `[T]`
- **Comments**: `//` line comments, `/* */` block comments

## Example

```rust
#[solana]
#[account]
struct PlayerAccount {
    wallet: PublicKey,
    level: u16,
    experience: u64,
    inventory: Vec<Item>,
}

#[solana]
enum GameState {
    Active,
    Paused { reason: String },
    Finished(u64),
}
```

## Troubleshooting

### LSP not starting

1. Verify `lumos-lsp` is installed:
   ```bash
   which lumos-lsp
   ```

2. Check LSP logs:
   ```vim
   :LspLog
   ```

3. Restart LSP:
   ```vim
   :LspRestart
   ```

### Syntax highlighting not working

1. Ensure nvim-treesitter is installed
2. Check Tree-sitter parser status:
   ```vim
   :TSInstallInfo lumos
   ```

3. Force reinstall parser:
   ```vim
   :TSInstall lumos
   ```

## Related Projects

- [lumos](https://github.com/getlumos/lumos) - Core LUMOS compiler and CLI
- [tree-sitter-lumos](https://github.com/getlumos/tree-sitter-lumos) - Tree-sitter grammar for LUMOS
- [vscode-lumos](https://github.com/getlumos/vscode-lumos) - VSCode extension for LUMOS
- [intellij-lumos](https://github.com/getlumos/intellij-lumos) - IntelliJ IDEA plugin for LUMOS

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

Dual-licensed under:
- MIT License ([LICENSE-MIT](LICENSE-MIT))
- Apache License 2.0 ([LICENSE-APACHE](LICENSE-APACHE))

## Support

- GitHub Issues: https://github.com/getlumos/nvim-lumos/issues
- Documentation: https://lumos-lang.org
