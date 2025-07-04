import { interval, Variable } from "astal";
import { fetch, URL } from "ags/fetch"

type WeatherDto = {
  coord: {
    lon: number;
    lat: number;
  },
  weather:
  {
    id: number;
    main: string;
    description: string;
    icon: string;
  }[];
  base: string;
  main: {
    temp: number;
    feels_like: number;
    temp_min: number;
    temp_max: number;
    pressure: number;
    humidity: number;
    sea_level: number;
    grnd_level: number;
  };
  visibility: number;
  wind: {
    speed: number;
    deg: number;
  };
  clouds: {
    all: number;
  };
  dt: number;
  sys: {
    type: number;
    id: number;
    country: string;
    sunrise: number;
    sunset: number;
  },
  timezone: number;
  id: number;
  cod: number;
  name: string;
};

export default class StatusController {
  private weather: Variable<WeatherDto | undefined>;

  readonly temperature: Variable<string> = new Variable("");
  readonly wind: Variable<string> = new Variable("");
  readonly humidity: Variable<string> = new Variable("");
  readonly time: Variable<string> = new Variable("");
  readonly dayDate: Variable<string> = new Variable("");
  readonly weekDay: Variable<number> = new Variable(0);
  readonly weekDays: Variable<boolean[]> = new Variable([]);
  readonly weekDots: Variable<string> = new Variable("");

  constructor() {
    this.weather = new Variable(undefined);

    this.timeRefresh();
    this.weatherRefresh();
  }

  private weatherRefresh() {
    this.getWeather();
    interval(60 * 60 * 1000, () => this.getWeather());
  }

  private async getWeather() {
    const city_id = "498817"
    const api_key = "2346fa4d5f6c0ab93c816ece6193746a"
    const unit = "metric"
    const lang = "en"

    const url = new URL(`https://api.openweathermap.org/data/2.5/weather?id=${city_id}&appid=${api_key}&cnt=5&units=${unit}&lang=${lang}`);

    const res = await fetch(url)
    const json = await res.json() as WeatherDto
    this.weather.set(json);
    this.setHumidity(json)
    this.setWind(json)
    this.setTemperature(json)
  }

  private setTemperature(w: WeatherDto) {
    this.temperature.set(`Today's in ${w.name} is ${w.weather[0].main} with temperature ${w.main.temp}°C`);
  }

  private setWind(w: WeatherDto) {
    this.wind.set(`Wind speed in your location is ${w.wind.speed}mph`);
  }

  private setHumidity(w: WeatherDto) {
    this.humidity.set(`And Humidity is ${w.main.humidity}%`)
  }

  private timeRefresh() {
    this.setTime()
    this.setDayDate();
    interval(1000, () => {
      this.setTimeVars();
    })
  }

  private setTimeVars() {
    const date = new Date()

    if (date.getSeconds() == 0) {
      this.setTime();
    }

    if (date.getHours() == 0) {
      this.setDayDate();
    }
  }

  private setTime() {
    const date = new Date()
    const time = date.toLocaleTimeString("en-US", {
      hour: "2-digit",
      minute: "2-digit",
      hour12: false,
    })
    this.time.set(time);
  }

  private setDayDate() {
    const date = new Date();
    const [dayDate, _] = date.toLocaleTimeString("en-US", {
      weekday: "long",
      month: "long",
      day: "numeric",
    }).split(" at");

    this.dayDate.set(dayDate);
    this.weekDay.set(date.getDay());
    this.weekDots.set(
      [...new Array(date.getDay()).fill(""), ...new Array(7 - date.getDay()).fill("")].join(' ')
    );
  }
}
