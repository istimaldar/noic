self: super:
let 
  runtimeLibs = super.lib.makeLibraryPath [
    super.curl
    super.glibc
    super.libudev0-shim
    super.nghttp2
    super.openssl
    super.stdenv.cc.cc.lib
  ];
in
{
  insomnia = super.insomnia.overrideAttrs (oldAttrs : {
      preFixup = ''
        wrapProgram "$out/bin/insomnia" "''${gappsWrapperArgs[@]}" --prefix LD_LIBRARY_PATH : ${runtimeLibs}
      '';
  });
}