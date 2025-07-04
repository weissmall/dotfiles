import { timeout } from "astal";
import { Astal, Gdk, Gtk } from "astal/gtk4"
import AstalCava from "gi://AstalCava?version=0.1";

export default function NetworkPopupWindow(gdkmonitor: Gdk.Monitor) {
  const cava = AstalCava.get_default();
  cava?.set_active(true);
  cava?.set_bars(20);
  return <window
    visible
    type="network"
    layer={Astal.Layer.TOP}
    anchor={Astal.WindowAnchor.BOTTOM}
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.NORMAL}
    keymode={Astal.Keymode.EXCLUSIVE}
    valign={Gtk.Align.START}
    hexpand
    cssClasses={[]}
    onKeyPressed={(self, keyval, keycode, state) => {
      if (keycode == 9) {
        timeout(500, () => {
          self.run_dispose();
        });
      }

      // Left
      if (keycode == 113) {

      }

      // Right
      if (keycode == 114) {

      }
    }}
  >
    <box>
      {/* <image file={"./assets/19.png"} pixelSize={400} /> */}
      {/* <image file={"./assets/19.png"} pixelSize={400} /> */}
      {/* <image file={"./assets/19.png"} pixelSize={400} /> */}
      {/* <image file={"./assets/19.png"} pixelSize={400} /> */}
      {/* <image file={"./assets/19.png"} pixelSize={400} /> */}
      {/* <image file={"./assets/19.png"} pixelSize={400} /> */}
    </box>
  </window >
}
