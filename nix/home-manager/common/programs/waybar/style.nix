{ ... }: ''
@define-color base   #3b4252;
@define-color mantle #181825;
@define-color crust  #4c566a;

@define-color text     #cdd6f4;
@define-color subtext0 #a6adc8;
@define-color subtext1 #bac2de;

@define-color surface0 #313244;
@define-color surface1 #45475a;
@define-color surface2 #585b70;

@define-color overlay0 #6c7086;
@define-color overlay1 #7f849c;
@define-color overlay2 #9399b2;

@define-color blue      #89b4fa;
@define-color lavender  #b4befe;
@define-color sapphire  #74c7ec;
@define-color sky       #89dceb;
@define-color teal      #94e2d5;
@define-color green     #a6e3a1;
@define-color yellow    #f9e2af;
@define-color peach     #fab387;
@define-color maroon    #eba0ac;
@define-color red       #bf616a;
@define-color mauve     #cba6f7;
@define-color flamingo  #f2cdcd;
@define-color rosewater #f5e0dc;

* {
  font-family: JetBrainsMono Nerd Font;
  font-size: 14px;
}

window#waybar {
  background-color: alpha(@base, 0.9);
  border: 2px solid alpha(@crust, 0.1);
}

#clock,
#battery,
#backlight,
#disk,
#pulseaudio,
#tray {
  padding: 0 10px;
}

#cpu,
#memory,
#network {
  padding: 0 7px;
}

#clock {
  color: @sky;
}

#wifi {
  color: @sapphire;
}

#battery {
  color: @green;
}

#pulseaudio {
  color: @flamingo;
}

#network {
  color: @maroon;
}

#backlight {
  color: @mauve;
}

#workspaces button {
  color: @text;
  border-radius: 16px;
  transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
}

#workspaces button:hover {
  background-color: @mauve;
}

#workspaces button.active {
  color: @maroon;
  background-color: shade(@surface1, 0.9);
}

.modules-right {
  background-color: @surface1;
  border-radius: 16px;
  margin: 5px 5px 5px 10px;
}

.modules-left {
  background-color: @surface1;
  border-radius: 16px;
  margin: 5px;
}

.modules-center {
  background-color: @surface1;
  border-radius: 16px;
  margin: 5px;
}

.custom-spotify {
  padding: 0 10px;
  color: @green;
}

.modules-left > widget:first-child > #workspaces {
  margin-left: 0;
}
''