import Wp from "gi://AstalWp"

type VolumeCommandArgs = {
  inc?: string;
  dec?: string;
  mute?: string;
};

export default function volumeCommandHandler({ inc, dec, mute }: VolumeCommandArgs) {
  const controller = Wp.get_default()?.get_default_speaker();

  if (!controller) {
    throw new Error("Failed to get volume controller");
  }

  if (mute) {
    controller?.set_mute(!controller.get_mute());
    return;
  }


  const cVolume = controller.get_volume();

  if (inc) {
    const value = parseInt(inc);
    const newValue = Math.floor(cVolume * 100 + value) / 100;
    if (newValue > 1) {
      controller?.set_volume(1)
      return;
    }
    controller?.set_volume(newValue)
  }

  if (dec) {
    const value = parseInt(dec);
    const newValue = Math.floor(cVolume * 100 - value) / 100;
    if (newValue < 0) {
      controller.set_volume(0);
    }
    controller?.set_volume(newValue);
  }
}
