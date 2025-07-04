// import { bind, exec, Variable } from "astal";
// import { Astal, Gdk, Gtk } from "astal/gtk4";
// import AstalCava from "gi://AstalCava?version=0.1";
// import Gsk from "gi://Gsk?version=4.0";
//
// function isCava() {
//   return exec("which cava") != ""
// }
//
// function CavaWidget() {
//   Gsk.PathBuilder
//   if (!isCava()) {
//     return <box></box>
//   }
//
//   const cava = AstalCava.get_default()
//   const values = new Variable<number[]>([])
//   cava?.connect("notify::values", () => {
//     values.set(cava.values)
//   });
//
//
//
//   return <box>{
//     bind(values).as((numbers) => numbers.map((number) => (
//       <CavaBar height={number} />
//     )))
//   }</box>
// }
//
// export default function CavaWindow(gdkmonitor: Gdk.Monitor) {
//   return <window
//     visible
//     type="cava"
//     anchor={Astal.WindowAnchor.BOTTOM}
//     layer={Astal.Layer.BOTTOM}
//     gdkmonitor={gdkmonitor}
//     exclusivity={Astal.Exclusivity.IGNORE}
//     valign={Gtk.Align.START}
//     defaultHeight={100}
//     heightRequest={100}
//   >
//     <CavaWidget />
//   </window >
// }
//
// function CavaBar({ height }: { height: number }) {
//   return <box vertical cssClasses={["bar"]} heightRequest={height * 100}></box>

import { register } from "astal";
import { Gdk, Gtk } from "astal/gtk4";
import AstalCava from "gi://AstalCava?version=0.1";
import Graphene from "gi://Graphene?version=1.0";
import Gsk from "gi://Gsk?version=4.0";

@register({ GTypeName: "CavaWidget" })
export default class CavaWidget extends Gtk.Widget {
  public cava: AstalCava.Cava;

  constructor(properties?: Partial<Gtk.Widget.ConstructorProps>, ...args: any[]) {
    super(properties, args);
    this.cava = AstalCava.get_default()!;
    this.cava.connect("notify::values", () => {
      this.queue_draw();
    });
  }

  override vfunc_snapshot(snapshot: Gtk.Snapshot): void {
    super.vfunc_snapshot(snapshot);
    this.draw_catmull_rom(snapshot);
  }

  private draw_catmull_rom(snapshot: Gtk.Snapshot) {
    const width = this.get_width();
    const height = this.get_height();
    const color: Gdk.RGBA = new Gdk.RGBA({
      red: 0,
      green: 0,
      blue: 255,
    });

    const values = this.cava.get_values();
    const bars = this.cava.bars;

    const bar_width = width / (bars - 1);

    const builder = new Gsk.PathBuilder();
    builder.move_to(0, height - height * values[0]);

    for (let i = 0; i <= bars - 2; i++) {
      let p0, p1, p2, p3: Graphene.Point;

      if (i == 0) {
        p0 = new Graphene.Point({ x: i * bar_width, y: height - height * values[i] });
        p3 = new Graphene.Point({ x: (i + 2) * bar_width, y: (height - height * values[i + 2]) });
      } else if (i == bars - 2) {
        p0 = new Graphene.Point({ x: (i - 1) * bar_width, y: (height - height * values[i - 1]) });
        p3 = new Graphene.Point({ x: (i + 1) * bar_width, y: (height - height * values[i + 1]) });
      } else {
        p0 = new Graphene.Point({ x: (i - 1) * bar_width, y: (height - height * values[i - 1]) });
        p3 = new Graphene.Point({ x: (i + 2) * bar_width, y: (height - height * values[i + 2]) });
      }

      p1 = { x: i * bar_width, y: (height - height * values[i]) };
      p2 = { x: (i + 1) * bar_width, y: (height - height * values[i + 1]) };

      const c1 = new Graphene.Point({ x: p1.x + (p2.x - p0.x) / 6, y: p1.y + (p2.y - p0.y) / 6 });
      const c2 = new Graphene.Point({ x: p2.x - (p3.x - p1.x) / 6, y: p2.y - (p3.y - p1.y) / 6 });

      builder.cubic_to(c1.x, c1.y, c2.x, c2.y, p2.x, p2.y);
    }

    builder.line_to(width, height);
    builder.line_to(0, height);

    builder.close();

    snapshot.append_fill(builder.to_path(), Gsk.FillRule.EVEN_ODD, color);
  }
}

