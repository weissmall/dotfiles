import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import Time from "./Time/Time"
import BatteryLevel from "./Battery/Battery"
import AudioSlider, { VolumeIconButton, VolumeSlider } from "./Audio/Audio"
import SysTray from "./Tray/Tray"
import Player from "./Player/Player"
import { BrightnessIconButton, BrightnessSlider } from "./Brightness/Brightness"
import { Gio } from "astal"

// Main Bar component
export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        visible
        cssClasses={["Bar"]}
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}
    >
        <centerbox>
            <box halign={Gtk.Align.START}>
                <Player />
            </box>
            <box halign={Gtk.Align.CENTER}>
                <Time />
            </box>
            <box halign={Gtk.Align.END}>
                <BatteryLevel />
                <VolumeIconButton />
                <BrightnessIconButton />
                <SysTray />
                <menubutton>
                    <image iconName="application-menu" />
                    <popover>
                        <box orientation={1}>
                            <box>
                                <VolumeIconButton />
                                <VolumeSlider />
                            </box>
                            <box>
                                <BrightnessIconButton />
                                <BrightnessSlider />
                            </box>
                        </box>
                    </popover>
                </menubutton>
            </box>
        </centerbox>
    </window>
}
