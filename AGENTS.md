# Repository Guidelines

## Project Structure & Module Organization

This repository is a Spanish-language Quarto book about data analysis with jamovi. Source chapters live at the repository root: `index.qmd` is the landing page, numbered files such as `02-plan-de-analisis.qmd` are chapters, and `a1-para-ir-mas-lejos.qmd` is an appendix. `_quarto.yml` defines book metadata, navigation order, and HTML options. Put downloadable worksheets, checklists, and jamovi files in `plantillas/`. Treat `_book/` and `.quarto/` as generated output; do not edit or commit them. Deployment is configured in `.github/workflows/publish.yml`.

## Build, Test, and Development Commands

- `quarto preview`: render the book, start a local server, and refresh after source changes.
- `quarto render`: perform the production build and write the site to `_book/`.
- `quarto publish gh-pages`: publish manually when configuring or troubleshooting GitHub Pages. Routine pushes to `main` are published by GitHub Actions.

Run `quarto render` before submitting changes. A successful full render is the primary automated validation for this content repository.

## Writing Style & Naming Conventions

Write reader-facing prose in Spanish and preserve the book's direct, instructional tone. Save text as UTF-8 and use standard Markdown with ATX headings. Use two spaces for YAML indentation. Keep chapter filenames lowercase, hyphen-separated, and prefixed with a two-digit sequence, for example `17-nuevo-tema.qmd`. Give reusable section identifiers descriptive Spanish slugs such as `{#sec-supuestos}`, and use Quarto cross-references (`@sec-supuestos`) instead of hard-coded chapter numbers. Prefer relative links for repository assets.

When adding a chapter, also place it in the appropriate `chapters` or `appendices` list in `_quarto.yml`.

## Testing Guidelines

There is no dedicated test framework or coverage target. Validate every change with `quarto render`, then inspect the affected pages through `quarto preview`. Check navigation, headings, cross-references, tables, callouts, downloads, and external links. Do not use generated files under `_book/` as test fixtures.

## Commit & Pull Request Guidelines

Git history is not included in this working copy, so no established commit convention can be inferred. Use short, imperative, scoped subjects, for example `Clarify assumptions in chapter 09`. Keep source and related navigation or asset updates in the same commit.

Pull requests should summarize the reader-facing change, list affected chapters, and confirm `quarto render` succeeds. Link relevant issues and include screenshots when layout, tables, figures, or callouts change. Do not include `_book/`, `.quarto/`, `.Rhistory`, or other local artifacts.

## Agent Collaboration

Before editing, read `PROJECT_LOG.md`. Claim one task there with your name, avoid files another agent owns, and record the result and validation before handing work off.
