{ fetchzip
, fetchurl
, lib
, sources ? ./sources.json
}:
let
    drvName = name: "${lib.strings.sanitizeDerivationName name}-src";

    fetch_tarball = name: spec: fetchzip {
        name = drvName name;
        inherit (spec) url sha256;
    };

    fetch_file = name: spec: fetchurl {
        name = drvName name;
        inherit (spec) url sha256;
    };

    fetch_local = _: spec: { outPath = /. + spec.path; };

    fetch = name: spec:
        if !(spec ? type) then throw "no type found in spec ${name}"
        else if spec.type == "tarball" then fetch_tarball name spec
        else if spec.type == "local" then fetch_local name spec
        else if spec.type == "file" then fetch_file name spec
        else if spec.type == "git" then throw "unimplemented"
        else throw "spec ${name} has unknown type ${builtins.toJSON spec.type}";
in lib.mapAttrs fetch (builtins.fromJSON (builtins.readFile sources))
