---- Editing

-- alt + backspace
vim.keymap.set({ 'c', 'i' }, '<a-bs>', '<c-w>')

-- alt + d
vim.keymap.set('c', '<a-d>', [[<c-\>ecmdline#alt_d()<cr>]])
vim.keymap.set('i', '<a-d>', '<c-o>de')

-- ctrl + k
vim.keymap.set('c', '<c-k>', [[<c-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<cr>]])
vim.keymap.set('i', '<c-k>', '<c-o>D')

-- ctrl + u
vim.keymap.set('i', '<c-u>', '<c-g>u<c-u>')

-- ctrl + w
vim.keymap.set('c', '<c-w>', [[<c-\>ecmdline#ctrl_w()<cr>]])
vim.keymap.set('i', '<c-w>', '<c-o>dB')

---- Moving

-- alt + b,f to go left or right
vim.keymap.set('c', '<a-b>', '<s-left>')
vim.keymap.set('i', '<a-b>', '<c-o>B')
vim.keymap.set('c', '<a-f>', '<s-right>')
vim.keymap.set('i', '<a-f>', '<c-o>W')

-- alt + h,j,k,l to navigate windows
vim.keymap.set({ 't', 'i' }, '<a-h>', [[<c-\><c-n><c-w>h]])
vim.keymap.set({ 't', 'i' }, '<a-j>', [[<c-\><c-n><c-w>j]])
vim.keymap.set({ 't', 'i' }, '<a-k>', [[<c-\><c-n><c-w>k]])
vim.keymap.set({ 't', 'i' }, '<a-l>', [[<c-\><c-n><c-w>l]])
vim.keymap.set('n', '<a-h>', '<c-w>h')
vim.keymap.set('n', '<a-j>', '<c-w>j')
vim.keymap.set('n', '<a-k>', '<c-w>k')
vim.keymap.set('n', '<a-l>', '<c-w>l')

-- ctrl + a to go to '^'
vim.keymap.set('c', '<c-a>', '<c-b>')

-- ctrl + w N to create a new window to the left
vim.keymap.set('n', '<c-w>N', ':leftabove vnew<cr>', { silent = true })

-- ctrl + w twice to go to the last accessed window
vim.keymap.set('n', '<c-w><c-w>', ':wincmd p<cr>', { silent = true })

-- ctrl + / to goto '^' and '$'
vim.keymap.set('n', '<c-left>',  '^')
vim.keymap.set('n', '<c-right>', '$')
vim.keymap.set('c', '<c-left>',  '<c-b>')
vim.keymap.set('c', '<c-right>', '<c-e>')
vim.keymap.set('i', '<c-left>',  '<c-o>^')
vim.keymap.set('i', '<c-right>', '<c-o>$')

-- ctrl +  to go up by a paragraph
vim.keymap.set('i', '<c-up>', '<c-o>{')
vim.keymap.set({ 'n', 'v', 'o' }, '<c-up>', '{')

-- ctrl +  to go down by a paragraph
vim.keymap.set('i', '<c-down>', '<c-o>}')
vim.keymap.set({ 'n', 'v', 'o' }, '<c-down>', '}')
