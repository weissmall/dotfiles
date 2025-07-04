import { bind } from "astal"
import Tray from "gi://AstalTray"

export default function SysTray() {
  const tray = Tray.get_default()
  const items = bind(tray, "items")

  return <box cssClasses={["SysTray"]}>
    {items.as(items => items.map((item) => (
      <menubutton
        setup={(self) => {
          self.insert_action_group("dbusmenu", item.actionGroup)
        }}
        tooltipMarkup={item.tooltipMarkup}
        menuModel={item.menuModel}
      >
        <image gicon={item.gicon} />
      </menubutton>
    )))}
  </box>
}
