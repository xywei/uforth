::  uforth: a Forth interpreter
::
::    The app is a work-in-progress.
::
/-  *uforth
/+  shoe, verb, dbug, default-agent, uforth
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 ds=stack cs=stack words=dict]
::
:: Stacks:
:: 1. ds: the data stack
:: 2. cs: the control structure stack
::
:: words: the runtime dictionary of words, a map from label -> code
::
+$  card  card:shoe
--
=|  state-0
=*  state  -
::
%+  verb  |
%-  agent:dbug
^-  agent:gall
%-  (agent:shoe token)
^-  (shoe:shoe token)
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    des   ~(. (default:shoe this token) bowl)
::
++  on-init   on-init:def
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  `this(state !<(versioned-state old))
::
++  on-poke   on-poke:def
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
::
++  command-parser
  :: TODO: allow entering multiple tokens at a time
  |=  =sole-id:shoe
  ^+  |~(nail *(like [? token]))
  %+  stag  |
  (cook token ;~(pose num:uforth ops:uforth))
::
++  tab-list
  |=  =sole-id:shoe
  ^-  (list [@t tank])
  :~  ['uforth' leaf+"may the forth be with you"]
  ==
::
++  on-command
  |=  [=sole-id:shoe =token]
  ^-  (quip card _this)
  ~&  "start processing command: {<token>}"
  =/  old-stack  (preprocess:uforth ds cs words token)
  :: =/  new-stack  (process:uforth old-stack)
  =/  new-stack  (process:uforth ds)
  :_  this(ds new-stack)
  :~  [%shoe ~ sole+klr+~[(crip "ds: {<old-stack>} →")]]
      [%shoe ~ sole+klr+~[[[`%br ~ `%g] (crip "    {<new-stack>}") ~]]]
      [%shoe ~ sole+klr+~[(crip "cs: {<old-stack>} →")]]
      [%shoe ~ sole+klr+~[[[`%br ~ `%g] (crip "    {<new-stack>}") ~]]]
      [%shoe ~ sole+klr+~[(crip "words: {<words>} →")]]
  ==
::
++  can-connect
  |=  =sole-id:shoe
  ^-  ?
  ?|  =(~zod src.bowl)
      (team:title [our src]:bowl)
  ==
::
++  on-connect      on-connect:des
++  on-disconnect   on-disconnect:des
--
