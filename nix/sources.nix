{ fetchzip
, lib
, sources ? ./sources.json
}:
let
    fetch_tarball = name: spec: fetchzip {
        name = lib.strings.sanitizeDerivationName name + "-src";
        inherit (spec) url sha256;
    };

    fetch = name: spec:
        if !(spec ? type) then abort "no type found in spec ${name}"
        else if spec.type == "tarball" then fetch_tarball name spec
        else abort "spec ${name} has unknown type ${builtins.toJSON spec.type}"
    ;
in lib.mapAttrs (name: spec: spec // { inherit (fetch name spec) outPath; }) (builtins.fromJSON (builtins.readFile sources))
