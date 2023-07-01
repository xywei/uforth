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
  |=  [stack=(list token:uforth) token=token:uforth]
  ^-  (list token:uforth)
  (weld stack ~[token])
::
:: process arm:
:: apply the operation at the top of the stack and return the new stack
:: FIXME: adapt to postfix notation
::
++  process
  |=  stack=(list token:uforth)
  ^-  (list token:uforth)
  ~|  "Failure processing operation on stack {<stack>}"
  ?~  stack  !!
  ?-    `token:uforth`(snag 0 (flop stack))
      [%op %add]
    =/  augend        ;;(@rs `token:uforth`(snag 1 (flop stack)))
    =/  addend        ;;(@rs `token:uforth`(snag 2 (flop stack)))
    (flop (weld ~[(add:rs augend addend)] (slag 3 (flop stack))))
    ::
      [%op %sub]
    =/  minuend       ;;(@rs `token:uforth`(snag 1 (flop stack)))
    =/  subtrahend    ;;(@rs `token:uforth`(snag 2 (flop stack)))
    (flop (weld ~[(sub:rs minuend subtrahend)] (slag 3 (flop stack))))
    ::
      [%op %mul]
    =/  multiplicand  ;;(@rs `token:uforth`(snag 1 (flop stack)))
    =/  multiplier    ;;(@rs `token:uforth`(snag 2 (flop stack)))
    (flop (weld ~[(mul:rs multiplicand multiplier)] (slag 3 (flop stack))))
    ::
      [%op %div]
    =/  numerator     ;;(@rs `token:uforth`(snag 1 (flop stack)))
    =/  denominator   ;;(@rs `token:uforth`(snag 2 (flop stack)))
    (flop (weld ~[(div:rs numerator denominator)] (slag 3 (flop stack))))
    ::
      [%op %mod]
    stack
    ::
      [%op %dup]
    stack
    ::
      [%op %drop]
    stack
    ::
      [%op %swap]
    stack
    ::
      [%op %clear]
    [~]
    ::
      [%op %wol]
    stack
    ::
      [%op %wor]
    stack
    ::
      [%op %sho]
    ~&  >  "{<(snag 1 (flop stack))>}"
    (flop (slag 1 (flop stack)))
    ::
      @rs
    stack
  ==
--
