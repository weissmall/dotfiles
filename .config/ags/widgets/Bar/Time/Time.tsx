import { interval, Variable } from "astal"
import { Gtk } from "astal/gtk4"

export default function Time() {
  const time = Variable("").poll(1000, () => {
    return new Date().toLocaleTimeString("en-US", {
      hour: "2-digit",
      minute: "2-digit",
      hour12: true,
    })
  })

  interval(1000, () => {
    const date = new Date();
    if (date.getSeconds() == 0) {
      time.set(
        date.toLocaleTimeString("en-US", {
          hour: "2-digit",
          minute: "2-digit",
          hour12: true,
        })
      );
    }
  })

  return <box
    cssClasses={["center-box"]}
  >
    <menubutton
      hexpand
      halign={Gtk.Align.CENTER}
    >
      <label label={time()} cssClasses={["Time"]} />
      <popover>
        <Gtk.Calendar />
      </popover>
    </menubutton>
  </box>
}
{ }
