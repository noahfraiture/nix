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
         a (tap-hold $tap-time $hold-time a lsft)
         s (tap-hold $tap-time $hold-time s lalt)
         d (tap-hold $tap-time $hold-time d lctl)
         f (tap-hold $tap-time $hold-time f lmet)

         j (tap-hold $tap-time $hold-time j rmet)
         k (tap-hold $tap-time $hold-time k rctl)
         l (tap-hold $tap-time $hold-time l ralt)
         ; (tap-hold $tap-time $hold-time ; rsft)
        )

        (deflayer base
         @a  @s  @d  @f  @j  @k  @l  @;
        )
      '';
    };
  };
}
