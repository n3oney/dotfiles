{pkgs, ...}: {
  leveldb-cli = pkgs.callPackage ./overlays/leveldb-cli {};
}
