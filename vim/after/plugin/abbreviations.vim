" Todo:
" Check all ll, pp, ss, nn words ?!
" Lang dependant? (ex: appeller)
"
" is it possible: Abolish have'nt haven't

if exists('g:loaded_abolish')

   " 2
   Abolish fo of
   Abolish si is
   Abolish ti it
   " 3
   Abolish adn and
   Abolish amn man
   Abolish hte the
   Abolish nad and
   Abolish nwe new
   Abolish teh the
   " 4
   Abolish alnd land
   Abolish amny many
   Abolish hutn hunt
   Abolish iwth with
   Abolish kpet kept
   Abolish olny only
   Abolish onyl only
   Abolish tihs this
   " 5
   Abolish ascci ascii
   Abolish spcae space
   Abolish whcih which
   " 6
   Abolish awlays always
   Abolish beneat beneath
   Abolish desier desire
   " 7
   " 8
   Abolish analysys analysis
   Abolish redifine redefine
   Abolish ubyquity ubiquity
   " 9
   Abolish pationate passionate
   Abolish profesion profession
   " 10
   Abolish aditionaly additionally
   Abolish rethorical rhetorical
   Abolish {help}full {}ful
   " 11
   Abolish convinience convenience
   Abolish holyday{,s} holiday{}
   Abolish profesional professional
   " 12
   Abolish colaboration collaboration
   Abolish developper{,s} developer{}

else

   " 1 Abolish not installed => use iabbrevs!
   " 2
   iabbrev fo of
   iabbrev si is
   iabbrev ti it
   " 3
   iabbrev adn and
   iabbrev amn man
   iabbrev hte the
   iabbrev nad and
   iabbrev nwe new
   iabbrev teh the
   " 4
   iabbrev alnd land
   iabbrev amny many
   iabbrev hutn hunt
   iabbrev iwth with
   iabbrev kpet kept
   iabbrev olny only
   iabbrev onyl only
   iabbrev tihs this
   " 5
   iabbrev ascci ascii
   iabbrev spcae space
   iabbrev whcih which
   " 6
   iabbrev awlays always
   iabbrev beneat beneath
   iabbrev desier desire
   " 7
   iabbrev holyday holiday
   " 8
   iabbrev analysys analysis
   iabbrev helpfull helpful
   iabbrev redifine redefine
   iabbrev ubyquity ubiquity
   " 9
   iabbrev pationate passionate
   iabbrev profesion profession
   " 10
   iabbrev aditionaly additionally
   iabbrev developper developer
   iabbrev rethorical rhetorical
   " 11
   iabbrev convinience convenience
   iabbrev profesional professional
   " 12
   iabbrev colaboration collaboration

endif

" vim: foldmethod=expr foldexpr=getline(v\:lnum)=~'"\\s\\d\\+'?'>1'\:'='
