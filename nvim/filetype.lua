vim.filetype.add({
    extension = {
        ftl = 'xml',
        pgn = 'pgn', -- chess
    },
    filename = {
        ['iptables'] = 'iptables',
        ['known_hosts'] = 'known_hosts',
        ['relayd.conf'] = 'pf',
    },
    pattern = {
        ['authorized_keys.*'] = 'authorized_keys',
        ['.*/postfix/aliases'] = 'mailaliases',
        ['r?syslog.*%.conf'] = 'syslog',
        ['.*/.*[aA]nsible.*/.+%.yml'] = 'yaml.ansible',
        ['.*/.*[aA]nsible.*/templates/.+%.json'] = 'json.jinja2',
        ['.*/zsh/autoload/.+'] = 'zsh',
        ['.*/zsh/after/.+'] = 'zsh'
    },
})
