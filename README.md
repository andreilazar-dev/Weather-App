# Weather-App

This is a small weather app made in a short time just a few days (I intend to expand it later) for training purposes and also to learn how to use bloc.
--

#
## API

The app is based on data taken from open weather.

For speed reasons I forced some logic to have everything so I preferred to fix the data in metric units.

I only used two endpoints to get the data. All inserted inside **WeatherRepository**

```dart
final weatherCityURl = (String cityName) =>
    '$baseUrl/data/2.5/forecast?q=${cityName}&appid=${token}&units=metric';
final weatherURL = (String lat, String lon) =>
    '$baseUrl/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=${token}&units=metric';
***
  //Give all week weather using City name
  Future<WeekWeather> getWeekWeatherByName(String cityName)
***
 //Give all week weather using lat and lon
  Future<WeekWeather> getWeekWeather(String lat, String lon) 
```
Being called via a private token, the private Token I inserted it inside an .env file in the root directory with inside:
**SECRET_API_KEY= XXXXXXXX**

the hierachy of the returned object is this:
```dart
WeekWeather
    String cod;
    int message;
    int cnt;
    List<Parameters>
        int dt;
        Main main; //this name is only because it is returned like this so for      continuity I leave it like this
            num temp;
            num feelsLike;
            num tempMin;
            num tempMax;
            int pressure;
            int seaLevel;
            int grndLevel;
            int humidity;
            num tempKf;
        List<Weather> weather;
            int id;
            WeatherCondition main;  //ENUM 
            String description;
            String  icon;
        Clouds clouds;
            int all;
        Wind wind;
            num speed;
            int deg;
            num gust;
        int visibility;
        num pop;
        Rain rain;
            num d3h;
        Sys sys;
            String pod;
        String dtTxt;
    City city
        int id;
        String name;
        Coord coord;
            num lat;
            num lon;
        String country;
        int population;
        int timezone;
        int sunrise;
        int sunset;
```

![test image size]<img src="https://fullpath/assets/yourgif.gif" width="400" height="790">
![My Image](images/screen1.png)
![My Image](images/screen2.png)
![My Image](images/search.png)