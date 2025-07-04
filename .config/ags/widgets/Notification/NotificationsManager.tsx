import AstalNotifd from "gi://AstalNotifd?version=0.1";
import { Gdk, Gtk } from "astal/gtk4"
import NotificationWidget from "./NotificationWidget";
import NotificationsWindow from "./NotificationsWindow";
import { Variable } from "astal";
import config from "../../config";

export default class NotificationsManager {
  private notifd: AstalNotifd.Notifd;
  private notifMap: Map<number, Gtk.Widget> = new Map();
  private notifVar: Variable<Array<Gtk.Widget>> = new Variable([]);

  constructor() {
    this.notifd = AstalNotifd.get_default();
    this.listen();
  }

  notificationWindow(gdkmonitor: Gdk.Monitor) {
    return NotificationsWindow(gdkmonitor, this);
  }

  private listen() {
    this.notifd.connect("notified", this.onNotified.bind(this));
    this.notifd.connect("resolved", this.onResolved.bind(this));
  }

  private onNotified(source: AstalNotifd.Notifd, id: number, replaced: boolean): void {
    const notification = this.notifd.get_notification(id);
    const expireIn = notification.expireTimeout <= 0 ? config.notifications.defaultTimeoutMs : notification.expire_timeout;
    // console.log("EXPIRE_OUT: ", expireIn)
    // console.log("EXPIRE_SRC: ", notification.expireTimeout)

    this.set(id,
      NotificationWidget({
        id: id,
        summary: notification.get_summary(),
        body: notification.get_body(),
        image: notification.get_image(),
        appName: notification.get_app_name(),
        time: new Date(notification.get_time()),
        delete: () => this.delete(id),
      }))

    setTimeout(() => {
      this.delete(id)
    }, expireIn)

  }

  private onResolved(_source: AstalNotifd.Notifd, id: number, reason: AstalNotifd.ClosedReason): void {
    this.delete(id);
  }

  private notify() {
    this.notifVar.set([...this.notifMap.values()].reverse())
  }

  private set(key: number, value: Gtk.Widget) {
    // this.notifMap.get(key)?.destroy()
    this.notifMap.set(key, value)
    this.notify()
  }

  private delete(key: number) {
    this.notifMap.delete(key)
    this.notify()
  }

  get() {
    return this.notifVar.get()
  }

  subscribe(callback: (list: Array<Gtk.Widget>) => void) {
    return this.notifVar.subscribe(callback);
  }

}
