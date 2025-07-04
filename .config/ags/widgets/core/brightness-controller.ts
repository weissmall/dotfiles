import GObject, { register, property } from "astal/gobject"
import { monitorFile, readFileAsync } from "astal/file"
import { exec, execAsync } from "astal/process"

const get = (args: string) => Number(exec(`brightnessctl ${args}`))
const screen = exec(`bash -c "ls -w1 /sys/class/backlight | head -1"`)

@register({ GTypeName: "Brightness" })
export default class BrightnessController extends GObject.Object {
  static instance: BrightnessController
  static get_default() {
    if (!this.instance) {
      this.instance = new BrightnessController()
    }

    return this.instance
  }

  #screenMax = get("max")
  #screen = get("get") / (get("max") || 1)

  @property(Number)
  get screen() { return this.#screen }

  set screen(percent) {
    if (percent < 0)
      percent = 0

    if (percent > 1)
      percent = 1

    execAsync(`brightnessctl set ${Math.floor(percent * 100)}% -q`).then(() => {
      this.#screen = percent
      this.notify("screen")
    })
  }

  get screenValue(): number {
    return Math.floor(this.screen * 100)
  }

  set screenValue(percent: number) {
    this.screen = percent / 100;
  }

  constructor() {
    super()
    monitorFile(`/sys/class/backlight/${screen}/brightness`, async f => {
      const v = await readFileAsync(f)
      this.#screen = Number(v) / this.#screenMax
      this.notify("screen")
    })
  }
}
