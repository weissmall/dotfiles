import { Binding, Variable } from "astal"
import { Widget } from "astal/gtk4"

export interface ToggleButtonProps extends Widget.ButtonProps {
    toggleHandler?: (self: typeof Widget.Button, on: boolean) => undefined
    state?: Binding<boolean> | boolean
    child?: JSX.Element
}

export function ToggleButton(btnprops: ToggleButtonProps) {
    const { state = false, onToggled, setup, child, ...props } = btnprops
    const innerState = Variable(state instanceof Binding ? state.get() : state)

    return <button
        {...props}
        setup={self => {
            setup?.(self)

            function toggleClassName(className: string, state: boolean) {
                if (state) {
                    self.add_css_class(className)
                } else {
                    self.remove_css_class(className)
                }
            }

            toggleClassName("active", innerState.get())

        }}
    >
        {child}
    </button>
}
