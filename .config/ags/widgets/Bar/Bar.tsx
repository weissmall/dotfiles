import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import Time from "./Time/Time"
import BatteryLevel from "./Battery/Battery"
import { VolumeIconButton, VolumeSlider } from "./Audio/Audio"
import SysTray from "./Tray/Tray"
import Player from "./Player/Player"
import { BrightnessIconButton, BrightnessSlider } from "./Brightness/Brightness"
import { PlayerButton } from "../Player/PlayerWindow"
import Network from "./network/network"
import StatusController from "../core/status-controller"

// Main Bar component
export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
  const sc = new StatusController();

  return <window
    visible
    cssClasses={["Bar"]}
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}
    application={App}
  >
    <centerbox
      cssClasses={["bar-box"]}
    >
      <box
        hexpand
        halign={Gtk.Align.FILL}
      >
        {/* <Player /> */}
      </box>

      <box
        hexpand
        halign={Gtk.Align.CENTER}
        cssClasses={["box-container"]}
      >
        <box
          cssClasses={["left-box"]}
        />
        <box
          cssClasses={["center-box-wrapper"]}
        >
          <Time />
        </box>
        <box
          cssClasses={["right-box"]}
        />
      </box>
      <box
        hexpand
        halign={Gtk.Align.FILL}
        cssClasses={["right"]}
      >
        <BatteryLevel />
        <VerticalSeparator />
        <VolumeIconButton />
        {PlayerButton(gdkmonitor)}
        <VerticalSeparator />
        <BrightnessIconButton />
        <VerticalSeparator />
        <Network />
        <VerticalSeparator />
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

function VerticalSeparator() {
  return <box
    cssClasses={['vertical-separator-box']}
    hexpand={false}
    vexpand={false}
  >
    <box
      cssClasses={['vertical-separator']}
    />
  </box>
}
