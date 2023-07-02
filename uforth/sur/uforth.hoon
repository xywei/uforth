|%
+$  op  $?  [%op %add]     :: math operator +
            [%op %sub]     :: math operator -
            [%op %mul]     :: math operator *
            [%op %div]     :: math operator /
            [%op %mod]     :: math operator mod
            ::
            [%op %wol]     :: start definition of a word
            [%op %wor]     :: end definition of a word
            ::
            [%op %drop]    :: drop a (data) stack item
            [%op %dup]     :: duplicate a (data) stack item
            [%op %swap]    :: swap the top two items
            [%op %clear]   :: clear all
            ::
            :: [%op %if]      :: conditional, false means 0, and nonzero values are treated as true
            :: [%op %endif]   :: end of if (replaces "then", like gforth)
            :: [%op %begin]   :: no-op, just a marker for %again
            :: [%op %again]   :: jump back to %begin
            :: [%op %leave]   :: break out of a loop
            ::
            [%op %sho]     :: show the stack
        ==
:: FIXME: only support single precision for now
+$  num  @rs
+$  word  @tas
+$  token  ?(num op word)
+$  stack  (list token)
+$  dict  (map word stack)
--
