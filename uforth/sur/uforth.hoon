|%
+$  op  $?  [%op %add]     :: math operator +
            [%op %sub]     :: math operator -
            [%op %mul]     :: math operator *
            [%op %div]     :: math operator /
            [%op %mod]     :: math operator mod
            ::
            [%op %drop]    :: drop a stack item
            [%op %dup]     :: duplicate a stack item
            [%op %swap]    :: swap the top two items
            ::
            :: [%op %if]      :: conditional, false means 0, and nonzero values are treated as true
            :: [%op %endif]   :: end of if (replaces "then", like gforth)
            :: [%op %begin]   :: no-op, just a marker for %again
            :: [%op %again]   :: jump back to %begin
            :: [%op %leave]   :: break out of a loop
            ::
            [%op %sho]     :: show the stack (. or .s)
            [%op %see]     :: show the "decompiled" source of a word
            ::
            [%op %col]     :: start definition of a word
            [%op %sem]     :: end definition of a word
        ==
:: FIXME: only support single precision for now
+$  num  @rs
+$  word  @tas
+$  token  ?(num op word)
--
