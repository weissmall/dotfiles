import { bind } from "astal"
import Battery from "gi://AstalBattery"

export default function BatteryLevel() {
    const battery = Battery.get_default()
    const isPresent = bind(battery, "isPresent")
    const iconName = bind(battery, "batteryIconName")
    const percentage = bind(battery, "percentage")

    if (!isPresent) return null

    return <box cssClasses={["Battery"]}>
        <image iconName={iconName} tooltipText={percentage.as(p => `${Math.floor(p * 100)} %`)} />
        <label label={percentage.as(p => `${Math.floor(p * 100)} %`)} />
    </box>
} 
