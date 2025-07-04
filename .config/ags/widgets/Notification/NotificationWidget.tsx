import { Gtk } from "astal/gtk4";
import config from "../../config";
import Chain from "../utils/chain";
import { ellipsis } from "../utils/utils";
import { timeout } from "astal";

export default function NotificationWidget(props: NotificationProps | undefined) {
  if (!props) {
    return <box />
  }

  const summary = new Chain(props.summary)
    .then((s) => ellipsis(s, config.notifications.text.maxSummaryLength))
    .get()

  const body = new Chain(props.body)
    .then((s) => !!s ? ellipsis(s, config.notifications.text.maxBodyLength) : s)
    .get()

  return <revealer
    setup={(self) => timeout(100, () => self.revealChild = true)}
    transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
    onDestroy={(self) => self.revealChild = false}
  >
    <box
      cssClasses={["Notification"]}
      hexpand
    >
      <box vertical hexpand>
        <box cssClasses={["header"]} hexpand>
          {props.app_icon && (
            <image
              cssClasses={["app-icon"]}
              file={props.image}
            />
          )}
          <box
            halign={Gtk.Align.FILL}
            hexpand
          >
            <label
              cssClasses={["app-name"]}
              label={props.appName}
            />
          </box>
          <label
            cssClasses={["time"]}
            label={props.time.toLocaleTimeString("en-US", {
              hour: "2-digit",
              minute: "2-digit",
              hour12: true,
            })}
          />
          <button
            cssClasses={["close"]}
            iconName={"cancel"}
            onClicked={props.delete}
          />
        </box>
        <box>
          {props.image && (
            <box
              cssClasses={["image-container"]}
              overflow={Gtk.Overflow.HIDDEN}
              vexpand={false}
              hexpand={false}
              widthRequest={50}
              heightRequest={50}
            >
              <image
                cssClasses={["image"]}
                file={props.image}
                pixelSize={-1}
              />
            </box>
          )}
          <box vertical>
            <box>
              <label
                cssClasses={["summary"]}
                label={summary}
              />
            </box>
            {props.body && (
              <box cssClasses={["separator"]} />
            )}
            {props.body && (
              <box>
                <label
                  cssClasses={["body"]}
                  label={body}
                  maxWidthChars={20}
                />
              </box>
            )}
          </box>
        </box>
      </box>
    </box>
  </revealer>
}

export type NotificationProps = {
  delete: () => void;
  summary: string;
  body?: string | undefined;
  app_icon?: string | undefined;
  image?: string | undefined;
  appName: string;
  time: Date;
  id: number;
};
