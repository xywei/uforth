|%
:: parsing rules
++  num     royl-rs:so
++  op-add  (cook |=(p=@ ?:(=('+' p) op+%add ~)) lus)
++  op-sub  (cook |=(p=@ ?:(=('-' p) op+%sub ~)) hep)
++  op-mul  (cook |=(p=@ ?:(=('*' p) op+%mul ~)) tar)
++  op-div  (cook |=(p=@ ?:(=('/' p) op+%div ~)) fas)
++  op-sho  (cook |=(p=@ ?:(=('.' p) op+%sho ~)) dot)
++  ops     ;~(pose op-add op-sub op-mul op-div op-sho)
--
