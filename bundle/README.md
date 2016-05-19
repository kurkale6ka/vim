# Add a module
`git submodule add git@github.com:tpope/vim-commentary.git bundle/vim-commentary`

# Delete a module
```
git submodule deinit bundle/nerdcommenter
git rm bundle/nerdcommenter
rm -rf .git/modules/bundle/nerdcommenter
```
