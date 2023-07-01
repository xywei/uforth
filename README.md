# uforth
A forth interpreter on Urbit.

Notes for self:
- Run `make` to start syncing with the desk on fake `zod`.
- After every change, inside fake `zod` (`|install` is only needed to run once):
   ```
   |commit %uforth
   |install our %uforth
   |link our %uforth
   ```
