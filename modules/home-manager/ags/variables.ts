import { refreshCss } from "utils/scss";
import { getSetting, setSetting } from "utils/settings";

const hyprland = await Service.import("hyprland");

export const globalOpacity = Variable<number>(getSetting("globalOpacity"));
globalOpacity.connect("changed", ({ value }) => {
  setSetting("globalOpacity", value);
  refreshCss();
});

export const globalMargin = 14;
export const globalTransition = 500;

export const emptyWorkspace = hyprland.active.client.bind("title").as((title) =>
  title ? 0 : 1
);

export const newAppWorkspace = Variable(0);
