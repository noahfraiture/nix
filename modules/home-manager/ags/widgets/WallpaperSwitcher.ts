import { globalTransition } from "variables";

const directories = (): { [key: string]: string[] } => {
  const dirs: { [key: string]: string[] } = {};
  Utils.exec(`ls ${App.configDir}/wallpapers`)
    .split("\n")
    .map((dir: string) => {
      const key = `${App.configDir}/wallpapers/${dir}`;
      const values = Utils.exec(`ls ${App.configDir}/wallpapers/${dir}`)
        .split("\n")
        .map((wallpaper: string) =>
          `${App.configDir}/wallpapers/${dir}/${wallpaper}`
        );
      dirs[key] = values;
    });
  return dirs;
};

const apply = (wallpaper: string) => {
  Utils.execAsync(
    `swww img --transition-type wipe --transition-step 120 ${wallpaper} `,
  )
    .catch((err) => Utils.notify(err));
};

function Wallpapers() {
  const getWallpapersButton = (wallpapers: string[]) => {
    const Box = Widget.Box({
      class_name: "all-wallpapers",
      spacing: 5,
      children: wallpapers.map((wallpaper: string) => {
        return Widget.Button({
          class_name: "wallpaper",
          css: `background-image: url('${wallpaper}');`,
          on_primary_click: () => apply(wallpaper),
        });
      }),
    });

    return Widget.Scrollable({
      class_name: "all-wallpapers-scrollable",
      hscroll: "always",
      vscroll: "never",
      hexpand: true,
      vexpand: true,
      child: Box,
    });
  };

  const getDirectoryButtons = () => {
    const dirs = directories();
    return Object.keys(dirs).map((directory) => {
      const image = dirs[directory][
        Math.floor(Math.random() * dirs[directory].length)
      ];

      return Widget.Button({
        vpack: "center",
        css: `background-image: url('${image}');`,
        class_name: "workspace-wallpaper",
        label: directory.split("/").at(-1),
        on_primary_click: (_, event) => {
          bottom.child.reveal_child = true;
          bottom.child.child.children = [
            bottom.child.child.children[0],
            getWallpapersButton(dirs[directory]),
          ];
        },
      });
    });
  };

  const top = Widget.Box({
    hexpand: true,
    vexpand: true,
    hpack: "center",
    spacing: 10,
    children: getDirectoryButtons(),
  });

  const random = Widget.Button({
    vpack: "center",
    class_name: "random-wallpaper",
    label: "",
    on_primary_click: () => {
      const allWallpapers = Object.values(directories()).flat();
      const randomWallpaper =
        allWallpapers[Math.floor(Math.random() * allWallpapers.length)];
      apply(randomWallpaper);
    },
  });

  const switchTheme = (theme: string) => {
    Utils.exec([
      "bash",
      "-c",
      `SHELL=/run/current-system/sw/bin/bash pkexec /nix/var/nix/profiles/system/specialisation/${theme}/bin/switch-to-configuration switch`,
    ]);
    Utils.exec([
      "nu",
      "-c",
      "ps | find hx | each { kill -s 10 $in.pid }",
    ]);
    Utils.exec(["bash", "-c", "hyprpanel -q -b hypr"]);
    Utils.execAsync("hyprpanel -b hypr");
  };

  const themeLight = Widget.Button({
    vpack: "center",
    class_name: "random-wallpaper",
    label: "light",
    on_primary_click: () => switchTheme("light"),
  });

  const themeDark = Widget.Button({
    vpack: "center",
    class_name: "random-wallpaper",
    label: "dark",
    on_primary_click: () => switchTheme("dark"),
  });

  const hide = Widget.Button({
    vpack: "center",
    class_name: "stop-selection",
    label: "",
    on_primary_click: () => {
      bottom.child.reveal_child = false;
    },
  });

  const actions = Widget.Box({
    class_name: "actions",
    hexpand: true,
    hpack: "center",
    children: [random, themeLight, themeDark, hide],
  });

  const bottom = Widget.Box({
    hexpand: true,
    vexpand: true,
    spacing: 10,
    child: Widget.Revealer({
      visible: true,
      reveal_child: false,
      transition: "slide_down",
      transition_duration: globalTransition,
      child: Widget.Box({
        vertical: true,
        children: [actions],
      }),
      // setup: (self) => timeout(1, () => self.reveal_child = false)
    }),
  });

  return Widget.Box({
    class_name: "wallpaper-switcher",
    vertical: true,
    children: [top, bottom],
  });
}

export default () => {
  return Widget.Window({
    name: `wallpaper-switcher`,
    class_name: "",
    anchor: [],
    visible: false,
    child: Wallpapers(),
  });
};
