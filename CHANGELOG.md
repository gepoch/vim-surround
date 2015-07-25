## 0.8.0
* Tentative support for
  [vim-mode-next](https://atom.io/packages/vim-mode-next). See
  [#28](https://github.com/gepoch/vim-surround/issues/28).

## 0.7.4
* Bugfixes.

## 0.7.3
* Fixed problems cause by vim-mode changing "command-mode" to "normal-mode".

## 0.7.1
* Propagate README changes.

## 0.7.0
* Change surround and delete surround implemented. Thanks to @shemerey :D !

## 0.6.1
* Fixed keymap -> keymaps change. [vim-surround #19](https://github.com/gepoch/vim-surround/issues/19)

## 0.6.0
* Upgraded to new config schema. General restructuring.

## 0.5.1
* Handle undefined values in config.

## 0.5.0
* Configurable surround key to support muscle memory in response to  [vim-surround #12](https://github.com/gepoch/vim-surround/issues/12)

## 0.4.3
* Fixed bug [vim-surround #13](https://github.com/gepoch/vim-surround/issues/13)


## 0.4.2
* Fixed bug [vim-surround #11](https://github.com/gepoch/vim-surround/issues/11)
* Readme updates.

## 0.4.1
* Renamed the dynamic keybindings to match the package name.
* Added some tests.
* Poked the README.

## 0.4.0
* Multiple cursor support.

## 0.3.0
* Updated for Atom API v1.0.0 changes.

## 0.2.3
* Fixed bug: [vim-surround #5](https://github.com/gepoch/vim-surround/issues/5)

## 0.2.0 - Activation and Keybindings Improved.
* Keybindings are now dynamically generated from the configured pairs. No more
  user keybindings changes necessary!
* Activation is now on atom boot since keybindings are now dynamic and
  impossible to predict for the purposes of activation events.
* Fixed bug where surround action did not exit visual mode.

## 0.1.0 - First Release
* Every feature added
* Every bug fixed
