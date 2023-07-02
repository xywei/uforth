/-  uforth
|%
::
:: parsing rules
::
++  num     royl-rs:so
++  op-add  (cook |=(p=@ ?:(=('+' p) op+%add ~)) lus)
++  op-sub  (cook |=(p=@ ?:(=('-' p) op+%sub ~)) hep)
++  op-mul  (cook |=(p=@ ?:(=('*' p) op+%mul ~)) tar)
++  op-div  (cook |=(p=@ ?:(=('/' p) op+%div ~)) fas)
++  op-mod  (cook |=(p=@ ?:(=('%' p) op+%mod ~)) cen)
++  op-dup  (cook |=(p=@ ?:(=('dup' p) op+%dup ~)) (jest 'dup'))
++  op-drop  (cook |=(p=@ ?:(=('drop' p) op+%drop ~)) (jest 'drop'))
++  op-swap  (cook |=(p=@ ?:(=('swap' p) op+%swap ~)) (jest 'swap'))
++  op-clear  (cook |=(p=@ ?:(=('clear' p) op+%clear ~)) (jest 'clear'))
++  op-sho  (cook |=(p=@ ?:(=('.' p) op+%sho ~)) dot)
++  op-wol  (cook |=(p=@ ?:(=(':' p) op+%wol ~)) col)
++  op-wor  (cook |=(p=@ ?:(=(';' p) op+%wor ~)) mic)
++  ops
  ;~  pose
    op-add
    op-sub
    op-mul
    op-div
    op-mod
    op-dup
    op-drop
    op-swap
    op-clear
    op-sho
    op-wol
    op-wor
  ==
::
:: preprocess arm:
:: Apply "compile time" operations, which include matching:
:: 1. : and ;
:: 2. if else then
:: 3. begin until
::
++  preprocess
  |=  [vm=vm:uforth token=token:uforth]
  ^-  vm:uforth
  =/  stack  ds.vm
  =/  cstack  cs.vm
  =/  words  words.vm
  [
    (weld stack ~[token])
    cstack
    words
  ]
::
:: process arm:
:: apply the operation at the top of the stack and return the new stack
:: FIXME: adapt to postfix notation
::
++  process
  |=  vm=vm:uforth
  ^-  vm:uforth
  =/  stack  ds.vm
  =/  cstack  cs.vm
  =/  words  words.vm
  ~|  "Failure processing operation on vm state {<vm>}"
  ?~  stack  !!
  :: FIXME: use ?- eventually
  :: ?-  `token:uforth`(snag 0 (flop stack))
  ?+  `token:uforth`(snag 0 (flop stack))  vm
      [%op %add]
    =/  augend        ;;(@rs `token:uforth`(snag 1 (flop stack)))
    =/  addend        ;;(@rs `token:uforth`(snag 2 (flop stack)))
    [(flop (weld ~[(add:rs augend addend)] (slag 3 (flop stack)))) cstack words]
    ::
      [%op %sub]
    =/  minuend       ;;(@rs `token:uforth`(snag 1 (flop stack)))
    =/  subtrahend    ;;(@rs `token:uforth`(snag 2 (flop stack)))
    [(flop (weld ~[(sub:rs minuend subtrahend)] (slag 3 (flop stack)))) cstack words]
    ::
      [%op %mul]
    =/  multiplicand  ;;(@rs `token:uforth`(snag 1 (flop stack)))
    =/  multiplier    ;;(@rs `token:uforth`(snag 2 (flop stack)))
    [(flop (weld ~[(mul:rs multiplicand multiplier)] (slag 3 (flop stack)))) cstack words]
    ::
      [%op %div]
    =/  numerator     ;;(@rs `token:uforth`(snag 1 (flop stack)))
    =/  denominator   ;;(@rs `token:uforth`(snag 2 (flop stack)))
    [(flop (weld ~[(div:rs numerator denominator)] (slag 3 (flop stack)))) cstack words]
    ::
      [%op %sho]
    ~&  >  "Data stack:    {<ds.vm>}"
    ~&  >  "Control stack: {<cs.vm>}"
    ~&  >  "Word list:     {<words.vm>}"
    vm
    ==
--
    ::
::      [%op %mod]
::    stack
::    ::
::      [%op %dup]
::    stack
::    ::
::      [%op %drop]
::    stack
::    ::
::      [%op %swap]
::    stack
::    ::
::      [%op %clear]
::    [~]
::    ::
::      [%op %wol]
::    stack
::    ::
::      [%op %wor]
::    stack
::    ::
::      @rs
::    stack
