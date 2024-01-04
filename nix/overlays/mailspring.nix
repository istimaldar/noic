self: super:
{
  mailspring = super.mailspring.overrideAttrs (oldAttrs: {
    postFixup = /* sh */ ''
      substituteInPlace $out/share/applications/Mailspring.desktop \
        --replace Exec=mailspring "Exec=$out/bin/mailspring --password-store=gnome-libsecret"
    '';
  });
}
