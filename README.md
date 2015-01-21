# Vim Surround for Atom

Surround is an implementation of vim-surround for the [atom](http://atom.io)
editor, creating a vim-surround with the power of Atom!
[vim-mode](https://atom.io/packages/vim-mode) is required for this package to
function properly.

Inspiration from and kudos to the wonderful [vim-surround for
vim](https://github.com/tpope/vim-surround)

See vim-surround on [github](https://github.com/gepoch/vim-surround) or
[atom.io](https://atom.io/packages/vim-surround).

Currently, this supports visual mode's `s )` set of commands for a configurable
set of pairs.



## How to use Surround

For double quotes, highlight the string in visual mode and enter `s "`.

```
Hello world -> "Hello world"
```

For parentheses there are two options. `s )` will surround as normal. `s (`
will pad with a space. All asymmetrical pairs have the secondary space-padded
form.

For example:

`s )`

```
Hello world -> (Hello world)
```

`s (`

```
Hello world -> ( Hello world )
```

New in 0.4: Multiple cursors are now supported, and conveniently work just
like you think they do.

Currently, the following pairs work out of the box!:

- ()
- []
- {}
- ""
- ''

You can add to the available pairs in atom's settings, and the commands will
be dynamically added to your keybindings.

For example if I wanted to add the pair '/\', I would add this in my settings:

```
(), [], {}, "", '', /\
```

Then:

`s \`

```
Hello world -> /Hello world\
```

`s /`

```
Hello world -> / Hello world \
```

### TODO

- [ ] Implement changing surrounding pairs with `c s`
- [ ] Implement deleting surrounding pairs with `d s`
- [ ] Intelligent tag surrounding/deleting/replacing with `s <q>` and friends.
