import { Gtk } from "astal/gtk4";
import config from "../../config";
import Chain from "../utils/chain";
import { ellipsis, ellipsisByLines } from "../utils/utils";
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
      {/* {props.app_icon && ( */}
      {/*   <image */}
      {/*     cssClasses={["app-icon"]} */}
      {/*     file={props.image} */}
      {/*   /> */}
      {/* )} */}
      <box vertical hexpand>
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
        {/* {props.image && ( */}
        {/*   <box cssClasses={["separator"]} /> */}
        {/* )} */}
        {/* {props.image && ( */}
        {/*   <image */}
        {/*     cssClasses={["image"]} */}
        {/*     file={props.image} */}
        {/*   /> */}
        {/* )} */}
      </box>
    </box>
  </revealer>
}

export type NotificationProps = {
  summary: string;
  body?: string | undefined;
  app_icon?: string | undefined;
  image?: string | undefined;
  id: number;
};
