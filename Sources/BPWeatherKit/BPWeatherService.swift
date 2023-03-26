import Foundation
import CoreLocation
import WeatherKit

@objcMembers open class BPWeatherService: NSObject, @unchecked Sendable {
    /// A single, shared weather service object.
    ///
    /// Use this object to interface to weather services in your application. If you need to prioritize weather information,
    /// create separate instances with `init`.
    @objc(sharedInstance) public static let shared: BPWeatherService = .init(weatherService: .shared)
    
    private let weatherService: WeatherService
    
    public convenience override init() {
        self.init(weatherService: .init())
    }
    
    @nonobjc private init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    @objc(weatherForLocation:completionHandler:)
    open func weather(for location: CLLocation) async throws -> BPWeather {
        let weather: Weather = try await weatherService.weather(for: location)
        return .init(weather: weather)
    }
    
    @objc(weatherForLocation:includingQueries:completionHandler:)
    open func weather(for location: CLLocation, including queries: [BPWeatherQuery]) async throws -> [Any] {
        return try await withThrowingTaskGroup(of: (Int, Any).self, returning: [Int: Any].self) { [weatherService] group in
            queries
                .enumerated()
                .forEach { index, query in
                    group.addTask {
                        let result: Any
                        
                        switch query.weatherQuery {
                        case .current:
                            result = try await weatherService.weather(for: location, including: .current) as Any
                        case .minute:
                            result = try await weatherService.weather(for: location, including: .minute) as Any
                        case .hourly:
                            result = try await weatherService.weather(for: location, including: .hourly) as Any
                        case .daily:
                            result = try await weatherService.weather(for: location, including: .daily) as Any
                        case .alerts:
                            result = try await weatherService.weather(for: location, including: .alerts) as Any
                        case .availability:
                            result = try await weatherService.weather(for: location, including: .availability) as Any
                        case ._daily(let startDate, let endDate):
                            result = try await weatherService.weather(for: location, including: .daily(startDate: startDate!, endDate: endDate!)) as Any
                        case ._hourly(let startDate, let endDate):
                            result = try await weatherService.weather(for: location, including: .hourly(startDate: startDate!, endDate: endDate!)) as Any
                        }
                        
                        return (index, result)
                    }
                }
            
            return try await group
                .reduce(.init()) { partialResult, next in
                    var result: [Int: Any] = partialResult
                    
                    var newValue: Any
                    
                    if let alerts: [WeatherAlert] = next.1 as? [WeatherAlert] {
                        newValue = alerts.map { BPWeatherAlert(weatherAlert: $0) }
                    } else if let availablity: WeatherAvailability = next.1 as? WeatherAvailability {
                        newValue = BPWeatherAvailablity(weatherAvailablity: availablity)
                    } else if let currentWeather: CurrentWeather = next.1 as? CurrentWeather {
                        newValue = BPCurrentWeather(currentWeather: currentWeather)
                    } else if let dailyForecast: Forecast<DayWeather> = next.1 as? Forecast<DayWeather> {
                        newValue = BPForecast(dailyForecast: dailyForecast)
                    } else if let hourlyForecast: Forecast<HourWeather> = next.1 as? Forecast<HourWeather> {
                        newValue = BPForecast(hourlyForecast: hourlyForecast)
                    } else if let minuteForecast: Forecast<MinuteWeather> = next.1 as? Forecast<MinuteWeather> {
                        newValue = BPForecast(minuteForecast: minuteForecast)
                    } else {
                        newValue = NSNull()
                    }
                    
                    result[next.0] = newValue
                    return result
                }
        }
        .sorted(by: { $0.key < $1.key })
        .map { $0.value }
    }
    
    open func attribution() async throws -> BPWeatherAttribution {
        try await .init(weatherAttribution: weatherService.attribution)
    }
}
