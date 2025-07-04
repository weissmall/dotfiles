import { exec } from "astal";

const config = {
  devMode: false,
  notifications: {
    enabled: true,
    dev: false,
    text: {
      maxSummaryLength: 30,
      maxBodyLength: 40,
    },
    defaultTimeoutMs: 3000,
  },
  bar: {
    enabled: true,
  },
  player: {
    enabled: false,
  },
  status: {
    enabled: true,
  },
  brightnessController: {
    pollInterval: 1000,
    pollCommand: "brightnessctl get",
    postPoll: (cmdResult: string) => {
      return parseInt(cmdResult) / parseInt(exec("brightnessctl max")) || 1;
    }
  }
};

export default config;
