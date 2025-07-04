import BrightnessController from "../../../widgets/core/brightness-controller";

type BrightnessCommandArgs = {
  inc?: string;
  dec?: string;
};

export default function brightnessCommandHandler({ inc, dec }: BrightnessCommandArgs) {
  let value: number | undefined = undefined;

  if (inc) {
    value = parseInt(inc);
  }

  if (dec) {
    value = parseInt(dec) * -1;
  }

  if (!value) {
    throw new Error("Failed to get brightness command value");
  }

  const controller = BrightnessController.get_default();
  controller.screenValue += value;
}
