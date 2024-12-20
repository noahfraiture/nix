{ ... }:
{
  services.kanata = {
    enable = true;
    keyboards.all = {
      extraDefCfg = "process-unmapped-keys yes";
      config = ''
        (defsrc
         a s d f j k l ;
        )
        (defvar
         tap-time 150
         hold-time 200
        )
        (defalias
         a (tap-hold $tap-time $hold-time a lmet)
         s (tap-hold $tap-time $hold-time s lalt)
         d (tap-hold $tap-time $hold-time d lsft)
         f (tap-hold $tap-time $hold-time f lctl)
         j (tap-hold $tap-time $hold-time j rctl)
         k (tap-hold $tap-time $hold-time k rsft)
         l (tap-hold $tap-time $hold-time l ralt)
         ; (tap-hold $tap-time $hold-time ; rmet)
        )

        (deflayer base
         @a  @s  @d  @f  @j  @k  @l  @;
        )
      '';
    };
  };
}