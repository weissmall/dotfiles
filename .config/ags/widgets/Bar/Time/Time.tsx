import { Variable } from "astal"
import { Gtk } from "astal/gtk4"

export default function Time() {
    const time = Variable("").poll(1000, () => {
        return new Date().toLocaleTimeString("en-US", {
            hour: "2-digit",
            minute: "2-digit",
            hour12: true,
        })
    })

    return <menubutton
        hexpand
        halign={Gtk.Align.CENTER}
    >
        <label label={time()} cssClasses={["Time"]} />
        <popover>
            <Gtk.Calendar />
        </popover>
    </menubutton>
} 
