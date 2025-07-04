import { bind } from "astal"
import NetworkController from "../../core/network-controller"

export default function Network() {
  const nc = new NetworkController()
  return <box>
    {bind(nc.wifiEnabled).as((enabled) => enabled && (
      <menubutton>
        <box>
          <image iconName={bind(nc.wifiIcon)} />
          <label label={bind(nc.wifiSsid)} visible={bind(nc.wifiConnected)} />
        </box>
        <popover
          setup={(self) => nc.scan()}
        >
          <box vertical>
            <button onClicked={() => nc.scan()}>
              <box>
                <label>RESCAN</label>
              </box>
            </button>
            <button onClicked={() => nc.disconnect()} visible={bind(nc.wifiConnected)} >
              <box>
                <label>{bind(nc.wifiSsid).as((ap) => `* ${ap}`)}</label>
              </box>
            </button>
            {bind(nc.wifiAccessPoints).as((aps) => aps.map((ap) => {
              if (ap) {
                return (
                  <button onClicked={() => {
                    nc.switchWifiStatus(ap)
                  }}>
                    <box>
                      <label>{ap}</label>
                    </box>
                  </button>
                )
              }
            }))}
          </box>
        </popover>
      </menubutton>
    ))}
  </box>
}
