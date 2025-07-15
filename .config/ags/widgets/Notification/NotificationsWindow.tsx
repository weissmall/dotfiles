import { Astal, Gdk, Gtk } from "astal/gtk4"
import { bind } from "astal"
import NotificationsManager from "./NotificationsManager";

export default function NotificationsWindow(
  gdkmonitor: Gdk.Monitor,
  manager: NotificationsManager,
) {

  return <window
    cssClasses={["NotificationsWindow", "dark-theme"]}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.NORMAL}
    type="notification"
    layer={Astal.Layer.TOP}
    valign={Gtk.Align.START}
    visible={bind(manager).as((arr) => arr.length != 0)}
    child={(
      <box
        vertical
        valign={Gtk.Align.START}
        cssClasses={["notification-box"]}
      >
        {bind(manager)}
      </box>
    )}
  />
}
