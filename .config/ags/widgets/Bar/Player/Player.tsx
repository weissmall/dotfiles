import Mpris from "gi://AstalMpris"
import { bind } from "astal"
import { Gtk } from "astal/gtk4"
import { ellipsis, stringOrNull } from "../../utils/utils"
import Chain from "../../utils/chain"
import NetworkController from "../../core/network-controller"

// Media Player component
function Media({ player }: { player: Mpris.Player }) {
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

  const available = bind(player, "available")
  const coverArt = bind(player, "coverArt")

  const artist = bind(player, "artist")
  const title = bind(player, "title")

  const canGoNext = bind(player, "canGoNext");
  const canGoPrevious = bind(player, "canGoPrevious");

  const playbackStatus = bind(player, "playbackStatus")

  if (!available) return null


  return <box cssClasses={["Media"]}>
    <button onButtonPressed={() => player.previous()} tooltipText={canGoPrevious.as((e) => !e ? "Not available" : "Previous")}>
      <image iconName="media-skip-backward" />
    </button>

    <button onButtonPressed={() => player.play_pause()}>
      <image iconName={playbackStatus.as(playIconByStatus)} />
    </button>


    <button onButtonPressed={() => player.next()} tooltipText={canGoNext.as((e) => !e ? "Not available" : "Next")}>
      <image iconName="media-skip-forward" />
    </button>

    <menubutton>
      <image iconName="view-more" />
      <popover cssClasses={["Info"]}>
        <box>
          <image cssClasses={["Cover"]} valign={Gtk.Align.CENTER} file={coverArt} />
          <box>
            <box orientation={1} halign={Gtk.Align.START}>
              <label cssClasses={["Title"]} label="Artist" halign={Gtk.Align.START} />
              <label cssClasses={["Title"]} label="Song" halign={Gtk.Align.START} />
            </box>
            <box orientation={1} halign={Gtk.Align.START}>
              <label
                cssClasses={["Description"]}
                halign={Gtk.Align.START}
                label={
                  artist.as(artist => new Chain(artist)
                    .then((artist) => stringOrNull(artist, "Unknown Artist"))
                    .then((artist) => ellipsis(artist, 20))
                    .get())
                } />
              <label
                cssClasses={["Description"]}
                halign={Gtk.Align.START}
                label={
                  title.as(title => new Chain(title)
                    .then((title) => stringOrNull(title, "Unknown Title"))
                    .then((title) => ellipsis(title, 40))
                    .get())
                } />
            </box>
          </box>
        </box>
      </popover>
    </menubutton>

  </box>
}

export default function Player() {
  const mpris = Mpris.get_default()
  const players = bind(mpris, "players")
  return <box cssClasses={["Players"]}>
    {players.as(players => players.map((player) => (
      <Media player={player} />
    )))}
  </box>
}
