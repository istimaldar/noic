{ ... }: [
  "1, monitor:$primary_monitor, on-created-empty:code, defaultName:vscode"
  "2, monitor:$ternary_monitor, default:true, on-created-empty:firefox, defaultName:browser"
  "3, monitor:$primary_monitor, default:true, on-created-empty:alacritty, defaultName:terminal"
  "4, monitor:$secondary_monitor, default:true, on-created-empty:slack & skypeforlinux, defaultName:work_messangers"
  "5, monitor:$primary_monitor, on-created-empty:logseq, defaultName:journal"
  "6, monitor:$secondary_monitor, on-created-empty:telegram-desktop, defaultName:telegram"
  "7, monitor:$primary_monitor, defaultName:ide_primary"
  "8, monitor:$secondary_monitor, on-created-empty:mailspring --password-store=gnome-libsecret, defaultName:mail"
  "9, monitor:$primary_monitor, defaultName:ide_secondary"
  "10, monitor:$ternary_monitor, on-created-empty:spotify, defaultName:spotify"
  "11, monitor:$primary_monitor, defaultName:ide_tertiary"
  "12, monitor:$secondary_monitor, on-created-empty:keepassxc, defaultName:passwords"
  "13, monitor:$secondary_monitor, on-created-empty:element-desktop, defaultName:element"
  "14, monitor:$secondary_monitor, on-created-empty:discord & whatsapp-for-linux, defaultName:discord"
  "15, monitor:$secondary_monitor, defaultName:devtools"
  "16, monitor:$primary_monitor, defaultName:ide_quaternary"
]
