\ Load file for application-specific Forth extensions

fl ../../lib/misc.fth
fl ../../lib/dl.fth
fl ../../lib/random.fth
fl ../../lib/ilog2.fth
fl ../../lib/tek.fth

warning @ warning off
: bye standalone?  if  restart  then  bye  ;
warning !

: .commit  ( -- )  'version cscount type  ;

: .built  ( -- )  'build-date cscount type  ;

: banner  ( -- )
   cr ." CForth built " .built
   ."  from " .commit
   cr
;

\ m-emit is defined in textend.c
alias m-key  key
alias m-init noop

: m-avail?  ( -- false | char true )
   key?  if  key true exit  then
   false
;

: ms>ticks  ( ms -- ticks )
   esp-clk-cpu-freq #80000000 over =
     if    drop
     else  #240000000 =
             if   exit
             else #1 lshift
             then
     then  #3 /
;

: ms ( ms - )
   get-msecs +
     begin   dup get-msecs - #10000 >
     while   #10000000 us
     repeat
   get-msecs - #1000 * 0 max us
;

fl wifi.fth

fl ../esp8266/xmifce.fth
fl ../../lib/crc16.fth
fl ../../lib/xmodem.fth
also modem
: rx  ( -- )  pad  unused pad here - -  (receive)  #100 ms  ;
previous

fl files.fth
fl server.fth
fl tasking_rtos.fth        \ Pre-empty multitasking

fl tools/extra.fth
fl tools/table_sort.f
fl tools/timediff.fth      \ Time calculations. The local time was received from a RPI
fl tools/webcontrols.fth   \ Extra tags in ROM
fl tools/svg_plotter.f
fl tools/rcvfile.fth
fl tools/wsping.fth
fl tools/schedule-tool.f   \ Daily schedule
fl ../sps30/sps30.fth      \ For sps30_webV2.fth


: interrupt?  ( -- flag )
   ." Type a key within 2 seconds to interact" cr
   #20 0  do  #100 ms  key?  if  key drop  true unloop exit  then   loop
   false
;

: load-startup-file  ( -- ior )   " start" ['] included catch   ;

: app ( - ) \ Sometimes SPIFFS or a wifi connection causes an error. A reboot solves that.
   banner  hex  interrupt? 0=
      if     s" start" file-exist?
           if   load-startup-file
                if   ." Reading SPIFFS. " cr interrupt? 0=
                    if    reboot
                    then
                then
           then
      then
   quit
;

alias id: \

" app.dic" save
