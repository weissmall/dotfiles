import { Gtk } from "astal/gtk4"
import { Gio } from "astal"

export default function MenuButton() {
    const menuModel = new Gio.Menu()
    menuModel.append("win.item1", null)
    return <menubutton
        cssClasses={["MenuButton"]}
        menuModel={menuModel}
        direction={Gtk.ArrowType.DOWN}
    >
        <image iconName="menu" />
        <popover>
            <Gtk.Calendar />
        </popover>
    </menubutton>
} 
