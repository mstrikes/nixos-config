let path = ../overlays; in
with builtins;
map (module: import (path + ("/" + module)))
  (filter
    (n: match ".*\\.nix" n != null ||
    pathExists (path + ("/" + n + "/default.nix")))
    (attrNames (readDir path)))
