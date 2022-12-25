-- firenvim: force manual triggering
if vim.fn.exists('g:started_by_firenvim') then
    vim.g.firenvim_config = [[
    {
        'localSettings': {
            '.*': {
                'selector': '',
                'priority': 0,
            }
        }
    }
    ]]
end
