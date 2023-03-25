import Foundation
import WeatherKit
import CoreLocation

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
    public func weather(for location: CLLocation) async throws -> BPWeather {
        let weather: Weather = try await weatherService.weather(for: location)
        return .init(weather: weather)
    }
}
