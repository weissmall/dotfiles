import { timeout, Variable } from "astal"
import { App, Astal, Gdk, Gtk } from "astal/gtk4"
import BrightnessController from "../core/brightness-controller"
import Wp from "gi://AstalWp"

function OnScreenProgress({ visible }: { visible: Variable<boolean> }) {
  const brightness = BrightnessController.get_default()
  const speaker = Wp.get_default()!.get_default_speaker()

  const iconName = Variable("")
  const value = Variable(0)

  let count = 0
  function show(v: number, icon: string) {
    visible.set(true)
    value.set(v)
    iconName.set(icon)
    count++
    timeout(1000, () => {
      count--
      if (count === 0) {
        visible.set(false);
      }
    })
  }


  return <box
    setup={(self) => {
      brightness.connect("notify", (src, _) => {
        show(src.screen, "display-brightness-symbolic")
      });
      speaker?.connect("notify", (src, pspec) => {
        if (pspec.get_name() == "volume") {
          show(src.volume, src.get_volume_icon())
        }
      });
    }}
    cssClasses={["OSD"]}
    visible={visible()}
  >
    <image iconName={iconName()} />
    <levelbar valign={Gtk.Align.CENTER} widthRequest={100} value={value()} />
    {/* <label label={value(v => `${Math.floor(v * 100)}%`)} /> */}
  </box>
}

export default function OSD(monitor: Gdk.Monitor) {
  const visible = Variable(false)

  return (
    <window
      gdkmonitor={monitor}
      cssClasses={["OSD"]}
      application={App}
      layer={Astal.Layer.OVERLAY}
      keymode={Astal.Keymode.NONE}
      anchor={Astal.WindowAnchor.BOTTOM}
      visible={visible()}
      child={(
        <box onButtonPressed={() => visible.set(false)}>
          <OnScreenProgress visible={visible} />
        </box>
      )}
    >
    </window>
  )
}
