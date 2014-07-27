# Surround for Atom

Surround is an implementation of vim-surround for the atom editor. vim-mode is
required to use this package.

Currently, this supports visual mode's `s )` set of commands for a configurable
set of pairs.

## How to use Surround

For double quotes, highlight the string in visual mode and enter `c s "`.

```
Hello world -> "Hello world"
```

For parentheses there are two options. `c s )` will surround as normal. `c s (`
will pad with a space. All assymetrical pairs have the secondary space-padded
form.

Currently, the following pairs are supported:

- ()
- []
- {}
- ""
- ''

You can add to the available pairs in atom's settings, and add your own
bindings in your keymap.

### TODO

Implement changing surrounding pairs with `c s`
