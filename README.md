# Moreutils

This is a tap that provides a `moreutils` Formula for [Homebrew](https://brew.sh/) with additional options.

## Options

The formula supports the following options:

- `--without-parallel`: Build without the 'parallel' tool
- `--without-errno`: Build without the 'errno' tool, for compatibility with 'pwntools'
- `--without-ts`: Build without the 'ts' tool, for compatibility with 'task-spooler'

## How do I install these formulae?

`brew install slhck/moreutils/moreutils`

Or `brew tap-pin slhck/moreutils` and then `brew install moreutils`.

Or install via URL (which will not receive updates):

```
brew install https://raw.githubusercontent.com/slhck/homebrew-moreutils/master/Formula/moreutils.rb
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
