# BPWeatherKit

WeatherKit for Objective-C (WIP)

**Work In Progress**

## Usage

```objc
@import CoreLocation;
@import BPWeatherKit;

CLLocation *location;

[BPWeatherService.sharedInstance weatherForLocation:location completionHandler:^(BPWeather * _Nullable weather, NSError * _Nullable error) {

}];
```
