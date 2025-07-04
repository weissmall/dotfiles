import { bind, Binding } from "astal";
import { Astal, Gdk, Gtk } from "astal/gtk4";
import Mpris from "gi://AstalMpris"

export default function PlayerWindow(gdkmonitor: Gdk.Monitor) {
  const mpris = Mpris.get_default()
  const players = bind(mpris, "players")
  return <window
    visible
    type="player"
    anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT}
    layer={Astal.Layer.BOTTOM}
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.IGNORE}
    valign={Gtk.Align.START}
    hexpand
    cssClasses={["PlayerWindow"]}
  >
    <box vertical>
      {PlayerBox(players)}
    </box>
  </window >
}

export function PlayerBox(players: Binding<Mpris.Player[]>) {
  return <box
    cssClasses={["PlayerContainer"]}
    vertical
    valign={Gtk.Align.START}
    hexpand
  >
    {players.as((p) => p.map((player) => Player(player)))}
  </box>
}

export function PlayerButton(gdkmonitor: Gdk.Monitor) {
  const mpris = Mpris.get_default()
  const players = bind(mpris, "players")
  return <box>
    {players.as((p) => p.length > 0 ? (
      <menubutton cssClasses={["PlayerPopoverWrapper"]}>
        <image
          cssClasses={["bar-music-icon"]}
          file={"./assets/icons/music-solid-white.svg"}
        />
        <popover cssClasses={["PlayerPopover"]}>
          {PlayerBox(players)}
        </popover>
      </menubutton>
    ) : (<box />))}
  </box>
}

function Player(player: Mpris.Player) {
  const available = bind(player, "available")
  const coverArt = bind(player, "coverArt")

  const artist = bind(player, "artist")
  const title = bind(player, "title")

  const canGoNext = bind(player, "canGoNext");
  const canGoPrevious = bind(player, "canGoPrevious");

  const playbackStatus = bind(player, "playbackStatus")

  function playIconByStatus(status: Mpris.PlaybackStatus): string {
    switch (status) {
      case Mpris.PlaybackStatus.PAUSED:
        return "media-playback-start";
      case Mpris.PlaybackStatus.STOPPED:
        return "media-playback-start";
      case Mpris.PlaybackStatus.PLAYING:
        return "media-playback-pause";
    }
  }

  return <box
    vertical
    vexpand
    hexpand
    halign={Gtk.Align.CENTER}
  >
    <box cssClasses={["player-cover-container"]} halign={Gtk.Align.CENTER}>
      <image cssClasses={["player-cover"]} valign={Gtk.Align.CENTER} file={coverArt} />
    </box>

    <label
      cssClasses={["player-artist"]}
      halign={Gtk.Align.CENTER}
      label={artist} />

    <label
      cssClasses={["player-title"]}
      halign={Gtk.Align.CENTER}
      label={title} />

    <box
      cssClasses={["player-buttons-container"]}
      halign={Gtk.Align.CENTER}
      hexpand
    >
      <box cssClasses={["player-button-container"]}>
        <button
          onButtonPressed={() => player.previous()}
          tooltipText={canGoPrevious.as((e) => !e ? "Not available" : "Previous")}
          cssClasses={["player-button", "player-other-button"]}
        >
          <image iconName="media-skip-backward" />
        </button>
      </box>

      <box cssClasses={["player-button-container"]}>
        <button
          onButtonPressed={() => player.play_pause()}
          cssClasses={["player-button", "play-button"]}
        >
          <image iconName={playbackStatus.as(playIconByStatus)} />
        </button>
      </box>


      <box cssClasses={["player-button-container"]}>
        <button
          onButtonPressed={() => player.next()}
          tooltipText={canGoNext.as((e) => !e ? "Not available" : "Next")}
          cssClasses={["player-button", "player-other-button"]}
        >
          <image iconName="media-skip-forward" />
        </button>
      </box>
    </box>
  </box>
}
