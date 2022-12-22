" Added \~\? after << and \s* after end=+^
syn region perlHereDocStart	matchgroup=perlStringStartEnd start=+<<\~\?\z(\I\i*\)+  end=+$+     contains=@perlTop oneline
syn region perlHereDocStart	matchgroup=perlStringStartEnd start=+<<\~\?\s*"\z([^\\"]*\%(\\.[^\\"]*\)*\)"+ end=+$+ contains=@perlTop oneline
syn region perlHereDocStart	matchgroup=perlStringStartEnd start=+<<\~\?\s*'\z([^\\']*\%(\\.[^\\']*\)*\)'+ end=+$+ contains=@perlTop oneline
syn region perlHereDocStart	matchgroup=perlStringStartEnd start=+<<\~\?\s*""+       end=+$+     contains=@perlTop oneline
syn region perlHereDocStart	matchgroup=perlStringStartEnd start=+<<\~\?\s*''+       end=+$+     contains=@perlTop oneline
if exists("perl_fold")
  syn region perlHereDoc	start=+<<\~\?\z(\I\i*\)+ matchgroup=perlStringStartEnd      end=+^\s*\z1$+ contains=perlHereDocStart,@perlInterpDQ fold extend
  syn region perlHereDoc	start=+<<\~\?\s*"\z([^\\"]*\%(\\.[^\\"]*\)*\)"+ matchgroup=perlStringStartEnd end=+^\s*\z1$+ contains=perlHereDocStart,@perlInterpDQ fold extend
  syn region perlHereDoc	start=+<<\~\?\s*'\z([^\\']*\%(\\.[^\\']*\)*\)'+ matchgroup=perlStringStartEnd end=+^\s*\z1$+ contains=perlHereDocStart,@perlInterpSQ fold extend
  syn region perlHereDoc	start=+<<\~\?\s*""+ matchgroup=perlStringStartEnd           end=+^\s*$+    contains=perlHereDocStart,@perlInterpDQ,perlNotEmptyLine fold extend
  syn region perlHereDoc	start=+<<\~\?\s*''+ matchgroup=perlStringStartEnd           end=+^\s*$+    contains=perlHereDocStart,@perlInterpSQ,perlNotEmptyLine fold extend
  syn region perlAutoload	matchgroup=perlStringStartEnd start=+<<\~\?\s*\(['"]\=\)\z(END_\%(SUB\|OF_FUNC\|OF_AUTOLOAD\)\)\1+ end=+^\s*\z1$+ contains=ALL fold extend
else
  syn region perlHereDoc	start=+<<\~\?\z(\I\i*\)+ matchgroup=perlStringStartEnd      end=+^\s*\z1$+ contains=perlHereDocStart,@perlInterpDQ
  syn region perlHereDoc	start=+<<\~\?\s*"\z([^\\"]*\%(\\.[^\\"]*\)*\)"+ matchgroup=perlStringStartEnd end=+^\s*\z1$+ contains=perlHereDocStart,@perlInterpDQ
  syn region perlHereDoc	start=+<<\~\?\s*'\z([^\\']*\%(\\.[^\\']*\)*\)'+ matchgroup=perlStringStartEnd end=+^\s*\z1$+ contains=perlHereDocStart,@perlInterpSQ
  syn region perlHereDoc	start=+<<\~\?\s*""+ matchgroup=perlStringStartEnd           end=+^\s*$+    contains=perlHereDocStart,@perlInterpDQ,perlNotEmptyLine
  syn region perlHereDoc	start=+<<\~\?\s*''+ matchgroup=perlStringStartEnd           end=+^\s*$+    contains=perlHereDocStart,@perlInterpSQ,perlNotEmptyLine
  syn region perlAutoload	matchgroup=perlStringStartEnd start=+<<\~\?\s*\(['"]\=\)\z(END_\%(SUB\|OF_FUNC\|OF_AUTOLOAD\)\)\1+ end=+^\s*\z1$+ contains=ALL
endif
