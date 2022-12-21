" Doesn't work
" TODO: fix? or keep using the python version...
finish

" if !exists('g:loaded_perl_provider')
"   finish
" endif

" perl -mcharnames -MEncode=decode -le 'print charnames::viacode ord decode "utf8", $ARGV[0], Encode::FB_CROAK | Encode::LEAVE_SRC' ...
function! s:UnicodeName()
perl << CODE
use charnames ();
my $byte = ($curwin->Cursor)[-1];
my $char = Neovim::Ext::call ('strpart', $current->line, $byte, 1, 'v:true');
say charnames::viacode ord $char;
CODE
endfunction

command! UnicodeName call s:UnicodeName()
