let path = ../packages; in
with builtins;
final: prev: (
builtins.listToAttrs (map
    (n: { name = n; value = final.callPackage (path + ("/" + n)) {}; })
  (filter
    (n: match ".*\\.nix" n != null ||
      pathExists (path + ("/" + n + "/default.nix")))
    (attrNames (readDir path))))
)

