# PlayerInitialSpawnForRealz
Mainly created as a way to tell if a client is fully connected
serverside, without the use of the net library

This idea was inspired by the warning example code on
https://wiki.facepunch.com/gmod/GM:PlayerInitialSpawn

I have just made it into it's own (serverside) hook and
a (shared) player metafunction to determine if the player
has been fully loaded serverside!

## Example code (serverside):
```lua
hook.Add("PlayerInitialSpawnForRealz", "PISFR_Example_1", function(ply, transition)
  MsgC(Color(255,155,155), ply:Nick(), Color(155,155,255), " has spawned for realz!\n")
end)
```

### Functions List
```lua
Functions:
  - player:HasSpawnedForRealz()
  - Returns boolean

  Hooks:
    - PlayerInitialSpawnForRealz( player ply, boolean transition )
```
