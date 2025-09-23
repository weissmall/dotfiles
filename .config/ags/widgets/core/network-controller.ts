import { exec, execAsync, register, Variable } from "astal";
import AstalNetwork from "gi://AstalNetwork?version=0.1";

export default class NetworkController {

  private network: AstalNetwork.Network;
  private wifi: AstalNetwork.Wifi | null;

  readonly wifiEnabled: Variable<boolean>;
  readonly wifiConnected: Variable<boolean>;
  readonly wifiSsid: Variable<string>;
  readonly wifiIcon: Variable<string>;
  readonly wifiAccessPoints: Variable<string[]>;

  constructor() {
    this.network = AstalNetwork.get_default();
    this.wifi = this.network.get_wifi()

    this.wifiSsid = new Variable("");
    this.wifiIcon = new Variable("");
    this.wifiConnected = new Variable(false);
    this.wifiAccessPoints = new Variable([]);
    this.wifiEnabled = new Variable(false);

    this.wifi?.connect("state-changed", (wifi) => {
      this.updateWifi(wifi);
    })

    if (this.wifi) {
      this.updateWifi(this.wifi);
    }
  }

  private updateWifi(wifi: AstalNetwork.Wifi) {
    this.wifiEnabled.set(wifi.get_enabled());
    this.wifiSsid.set(wifi.get_ssid());
    this.wifiIcon.set(wifi.get_icon_name());
    this.wifiConnected.set(wifi.get_active_connection() != null);


    const accessPoints =
      new Set(wifi.get_access_points()
        .map((ap) => ap.get_ssid())
        .filter((ap) => ap != null)
        .filter((ap) => ap != this.wifiSsid.get())
        .sort());

    this.wifiAccessPoints.set(Array.from(accessPoints));
  }

  switchWifiStatus(accessPointName: string) {
    if (this.wifiSsid.get() === accessPointName) {
      execAsync(`nmcli connection down ${accessPointName}`)
    } else {
      execAsync(`nmcli connection up ${accessPointName}`)
    }
  }

  disconnect() {
    execAsync(`nmcli connection down ${this.wifiSsid.get()}`)
  }

  scan() {
    if (!this.wifi?.scanning) {
      this.wifi?.scan();
    }
  }
}
