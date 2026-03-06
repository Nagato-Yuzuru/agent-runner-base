# Global Preferences

## JavaScript / TypeScript — Package Manager

- Always use `pnpm` instead of `npm` for all package operations.
- Never run `npm install`, `npm ci`, `npm run`, or `npx`.

| Intent               | Command                                  |
| -------------------- | ---------------------------------------- |
| Install dependencies | `pnpm install`                           |
| Add a package        | `pnpm add <pkg>`                         |
| Run a script         | `pnpm run <script>` or `pnpm <script>`   |
| One-off execution    | `pnpm dlx <pkg>` or `deno run npm:<pkg>` |

Prefer deno run npm:<pkg> over pnpm dlx when the tool is non-interactive and has minimal system access (e.g. formatters, type checkers, code generators with no file I/O). For interactive CLI tools or tools that require filesystem/network access, use pnpm dlx.

## Python — Toolchain

- Always use `uv` for environment and dependency management.
- Never use `pip`, `pip3`, `python -m pip`, `virtualenv`, or `poetry`.

| Intent                    | Command              |
| ------------------------- | -------------------- |
| Create / sync environment | `uv sync`            |
| Add a package             | `uv add <pkg>`       |
| Add a dev dependency      | `uv add --dev <pkg>` |
| Run a script              | `uv run <script>`    |
| One-off tool execution    | `uvx <tool>`         |
| Run Python directly       | `uv run python`      |

- Always use `ty` for static type checking instead of `mypy` or `pyright`.

| Intent                     | Command           |
| -------------------------- | ----------------- |
| Type-check current project | `ty check`        |
| Type-check a specific file | `ty check <path>` |
