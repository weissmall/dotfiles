import { App } from "astal/gtk4"
import style from "./style.scss"
import Bar from "./widgets/Bar/Bar"
import NotificationsManager from "./widgets/Notification/NotificationsManager";
import config from "./config";
import PlayerWindow from "./widgets/Player/PlayerWindow";
import OSD from "./widgets/OSD/OSD";
import NetworkPopupWindow from "./widgets/network/network-popup";
import StatusWindow from "./widgets/Player/status";
import CommandsHandler from "./src/core/commands/commands-handler";
import brightnessCommandHandler from "./src/features/brightness/brightness-command-handler";
import volumeCommandHandler from "./src/features/brightness/volume-command-handler";
import Applauncher from "./widgets/apps/launcher";

function networkCommand(res: (response: any) => void) {
  // App.get_monitors().map((mon) => );
  res("network command executed");
  App.get_monitors().map((mon) => NetworkPopupWindow(mon));
}

const cHandler = new CommandsHandler();
cHandler.registerCommand("brightness", brightnessCommandHandler);
cHandler.registerCommand("volume", volumeCommandHandler);

App.start({
  css: style,
  instanceName: config.devMode ? "astal-dev" : "Astal",
  requestHandler(request: string, res: (response: any) => void) {
    const result = cHandler.handleCommandSafe(request, res);
    if (result) {
      return;
    }

    if (request.indexOf("network") != -1) {
      return networkCommand(res);
    }
    res("unknown command")
  },
  main() {
    const launch = Applauncher();
    // launch.visible = !launch.visible;
    if (config.notifications.enabled) {
      const nm = new NotificationsManager();
      App.get_monitors().map((mon) => nm.notificationWindow(mon))
    }

    if (config.player.enabled) {
      App.get_monitors().map(PlayerWindow);
    }

    App.get_monitors().map((mon) => OSD(mon))
    if (config.status.enabled) {
      App.get_monitors().map((mon) => StatusWindow(mon))
    }
    // App.get_monitors().map((mon) => CavaWindow(mon))

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
