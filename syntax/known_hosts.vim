" Highlighting for ~/.ssh/known_hosts

syntax match knownHostsDNS /^\S\+/
syntax match knownHostsType /\%(^\S\+\s\+\)\@<=\S\+/

highlight link knownHostsDNS Identifier
highlight link knownHostsType Type
