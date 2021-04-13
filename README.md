# Moreutils

This is a tap that provides a `moreutils` Formula for [Homebrew](https://brew.sh/) with additional options.

## Options

The formula supports the following options:

- `--without-parallel`: Build without the 'parallel' tool
- `--without-errno`: Build without the 'errno' tool, for compatibility with 'pwntools'
- `--without-sponge`: Build without the 'sponge' tool, for compatibility with 'sponge'
- `--without-ts`: Build without the 'ts' tool, for compatibility with 'task-spooler'

## Installation

Simply run:

```
brew install slhck/moreutils/moreutils
```

## `parallel` won't upgrade?

If your Homebrew installation complains about not upgrading `parallel`, run:

```
brew unlink moreutils && brew install parallel && brew link moreutils
```
