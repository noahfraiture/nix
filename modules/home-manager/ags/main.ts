import AppLauncher from "widgets/AppLauncher";
import Progress from "widgets/Progress";
import WallpaperSwitcher from "widgets/WallpaperSwitcher";

import { getCssPath, refreshCss } from "utils/scss";

// required packages
// gvfs is required for images

refreshCss();

App.addIcons(`${App.configDir}/assets/icons`);
App.config({
  style: getCssPath(),
  windows: [
    WallpaperSwitcher(),
    AppLauncher(),
    Progress(),
  ],
});
