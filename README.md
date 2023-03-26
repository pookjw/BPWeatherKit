# BPWeatherKit

[WeatherKit](https://developer.apple.com/documentation/weatherkit) for Objective-C

BP is the abbreviation for Back to the Past!

## Usage

```objc
@import CoreLocation;
@import BPWeatherKit;

CLLocation *location = [[CLLocation alloc] initWithLatitude:33.6405 longitude:117.8443];

// Fetch all data
[BPWeatherService.sharedInstance weatherForLocation:location completionHandler:^(BPWeather * _Nullable weather, NSError * _Nullable error) {
    BPCurrentWeather *currentWeather = weather.currentWeather;
    
    // value: 6.820000 unit: °C
    NSLog(@"temperature : %@", currentWeather.temperature);
    
    // value: 6.770000 unit: km/h
    NSLog(@"wind speed : %@", currentWeather.wind.speed);
}];
```
