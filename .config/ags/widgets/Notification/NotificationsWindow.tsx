import { Astal, Gdk, Gtk } from "astal/gtk4"
import { bind, Variable } from "astal"
import NotificationsManager from "./NotificationsManager";

export default function NotificationsWindow(
  gdkmonitor: Gdk.Monitor,
  manager: NotificationsManager,
) {

  return <window
    cssClasses={["NotificationsWindow"]}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    visible={bind(manager).as((arr) => arr.length != 0)}
    type="notification"
    layer={Astal.Layer.TOP}
    valign={Gtk.Align.START}
  >
    <box
      vertical
      valign={Gtk.Align.START}
      cssClasses={["notification-box"]}
    >
      {bind(manager)}
    </box>
  </window >
}
