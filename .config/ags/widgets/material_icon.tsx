import { Widget } from "astal/gtk3"

export const MaterialIcon = (icon: string, size: number, props = {}) => new Widget.Label({
    className: `icon-material txt-${size}`,
    label: icon,
    ...props,
})