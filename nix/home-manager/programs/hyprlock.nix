_: {
  enable = true;
  settings = {
    general = {
      hide_cursor = true;
    };
    background = {
      path = "~/common/wallpaper-3440x1440.png";
      blur_passes = 1;
      blur_size = 7;
      noise = 0.0117;
      contrast = 0.8916;
      brightness = 0.8172;
      vibrancy = 0.1696;
      vibrancy_darkness = 0.0;
    };
    input-field = {
      size = "200, 50";
      outline_thickness = 3;
      dots_size = 0.33;
      dots_spacing = 0.15;
      dots_center = false;
      dots_rounding = -1;
      outer_color = "rgb(151515)";
      inner_color = "rgb(200, 200, 200)";
      font_color = "rgb(10, 10, 10)";
      fade_on_empty = true;
      fade_timeout = 1000;
      placeholder_text = "<i>Input Password...</i>";
      hide_input = false;
      rounding = -1;
      check_color = "rgb(204, 136, 34)";
      fail_color = "rgb(204, 34, 34)";
      fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
      fail_timeout = 2000;
      fail_transition = 300;
      capslock_color = -1;
      numlock_color = -1;
      bothlock_color = -1;
      invert_numlock = false;
      swap_font_color = false;

      position = "0, -20";
      halign = "center";
      valign = "center";
    };
  };
}
