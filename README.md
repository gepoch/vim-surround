# Vim Surround for Atom

Surround is an implementation of vim-surround for the [atom](http://atom.io)
editor. vim-mode is required to use this package.

Inspiration from and kudos to the wonderful [vim-surround for
vim](https://github.com/tpope/vim-surround)

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
