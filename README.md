# Vim Surround for Atom [![Build Status](https://travis-ci.org/gepoch/vim-surround.svg?branch=master)](https://travis-ci.org/gepoch/vim-surround)

Surround is an implementation of vim-surround for the [atom](http://atom.io)
editor, creating a vim-surround with the power of Atom!

You should definitely have [vim-mode](https://atom.io/packages/vim-mode) for
this package to function properly, of course.

Inspiration from and kudos to the wonderful [vim-surround for
vim](https://github.com/tpope/vim-surround)

See vim-surround on [github](https://github.com/gepoch/vim-surround) or
[atom.io](https://atom.io/packages/vim-surround).

## News

* This package supports visual mode's `s )` set of commands for a configurable
  set of pairs.

* Next on the roadmap are pair deletions with `d )` and friends.

* New in 0.4: Multiple cursors are now supported, and conveniently work just
  like you think they do.

* New in 0.5: Stable configuration changes and configurable surround key!

* New in 0.7: Change surround and delete surround added.

* New in 0.8: Tentative support for
  [vim-mode-next](https://atom.io/packages/vim-mode-next). See
  [#28](https://github.com/gepoch/vim-surround/issues/28).

### Muscle Memory Compatability Note

vim-surround uses a lowercase `s` instead of `S` for surround commands! This is
configurable in the package settings, if you would like to set it to the
original keybinding.

## How to use Surround

### Surrounding

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

### Changing Surrounding Pairs

Suppose I want to make double quotes into single quotes. To do this, I should
put my cursor inside the double quotes in question and enter `c s " '`

```
"Hello world" -> 'Hello world'
```

### Deleting Surrounding Pairs

To delete the single quotes, place your cursor inside of them and enter `d s '`

```
'Hello world' -> Hello world
```
### Configuration

Currently, the following pairs work out of the box!:

- ()
- []
- {}
- ""
- ''

You can add to the available pairs in atom's settings, and the commands will
be dynamically added to your keybindings.

For example if I'm working on Jinja templates, and I want to add the ability to
surround using `{%` and `%}` I would add this in my settings:

```
(), [], {}, "", '', {%%}
```

Then:

`s % }`

```
Hello world -> {%Hello world%}
```

`s { %`

```
Hello world -> {% Hello world %}
```

### TODO

- [x] Implement deleting surrounding pairs with `d s`
- [x] Implement changing surrounding pairs with `c s`
- [ ] Intelligent tag surrounding/deleting/replacing with `s <q>` and friends.
