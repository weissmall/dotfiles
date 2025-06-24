import { App, Gtk } from "astal/gtk4"
import style from "./style.scss"
import Bar from "./widgets/Bar/Bar"
import NotificationsManager from "./widgets/Notification/NotificationsManager";
import config from "./config";
import NotificationsWindow from "./widgets/Notification/NotificationsWindow";
import { VarMap } from "./widgets/utils/varmap";
import NotificationWidget, { NotificationProps } from "./widgets/Notification/NotificationWidget";
import { Variable } from "astal";
import PlayerWindow from "./widgets/Player/PlayerWindow";

App.start({
  css: style,
  instanceName: config.devMode ? "astal-dev" : "Astal",
  main() {
    if (config.notifications.enabled) {
      const nm = new NotificationsManager();
      App.get_monitors().map((mon) => nm.notificationWindow(mon))
    }

    if (config.player.enabled) {
      App.get_monitors().map(PlayerWindow);
    }

    // if (config.notifications.dev) {
    //   const vm = new VarMap<number, Gtk.Widget>([])
    //   const notification = new Variable<NotificationProps | undefined>(undefined);
    //
    //   App.get_monitors().map((mon) => {
    //     NotificationsWindow(mon, notification, {});
    //   });
    //
    //   setTimeout(() => {
    //     notification.set({
    //       summary: "Test notification summary",
    //       body: "Test notification body for showiwng large message",
    //       app_icon: undefined,
    //       image: undefined,
    //       id: 1,
    //     })
    //   }, 1000);
    // }

    if (config.bar.enabled) {
      App.get_monitors().map(Bar)
    }
  },
})
