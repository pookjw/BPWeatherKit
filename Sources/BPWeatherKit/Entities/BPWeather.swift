import Foundation
import WeatherKit

@objcMembers open class BPWeather: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let availability: BPWeatherAvailablity
    public let currentWeather: BPCurrentWeather
    public let dailyForecast: BPForecast
    public let hourlyForecast: BPForecast
    public let minuteForecast: BPForecast?
    public let weatherAlerts: [BPWeatherAlert]?
    
    public required convenience init?(coder: NSCoder) {
        guard
            let availability: BPWeatherAvailablity = coder.decodeObject(forKey: #keyPath(availability)) as? BPWeatherAvailablity,
            let currentWeather: BPCurrentWeather = coder.decodeObject(forKey: #keyPath(currentWeather)) as? BPCurrentWeather,
            let dailyForecast: BPForecast = coder.decodeObject(forKey: #keyPath(dailyForecast)) as? BPForecast,
            let hourlyForecast: BPForecast = coder.decodeObject(forKey: #keyPath(hourlyForecast)) as? BPForecast
        else {
            return nil
        }
        
        let minuteForecast: BPForecast? = coder.decodeObject(forKey: #keyPath(minuteForecast)) as? BPForecast
        let weatherAlerts: [BPWeatherAlert]? = coder.decodeObject(forKey: #keyPath(weatherAlerts)) as? [BPWeatherAlert]
        
        self.init(
            availability: availability,
            currentWeather: currentWeather,
            dailyForecast: dailyForecast,
            hourlyForecast: hourlyForecast,
            minuteForecast: minuteForecast,
            weatherAlerts: weatherAlerts
        )
    }
    
    @nonobjc public convenience init(weather: Weather) {
        let minuteForecast: BPForecast?
        if let _minuteForecast: Forecast<MinuteWeather> = weather.minuteForecast {
            minuteForecast = .init(minuteForecast: _minuteForecast)
        } else {
            minuteForecast = nil
        }
        
        self.init(
            availability: .init(weatherAvailablity: weather.availability),
            currentWeather: .init(currentWeather: weather.currentWeather),
            dailyForecast: .init(dailyForecast: weather.dailyForecast),
            hourlyForecast: .init(hourlyForecast: weather.hourlyForecast),
            minuteForecast: minuteForecast,
            weatherAlerts: weather.weatherAlerts?.map { BPWeatherAlert(weatherAlert: $0) }
        )
    }
    
    @nonobjc private init(
        availability: BPWeatherAvailablity,
        currentWeather: BPCurrentWeather,
        dailyForecast: BPForecast,
        hourlyForecast: BPForecast,
        minuteForecast: BPForecast?,
        weatherAlerts: [BPWeatherAlert]?
    ) {
        self.availability = availability
        self.currentWeather = currentWeather
        self.dailyForecast = dailyForecast
        self.hourlyForecast = hourlyForecast
        self.minuteForecast = minuteForecast
        self.weatherAlerts = weatherAlerts
        
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(availability, forKey: #keyPath(availability))
        coder.encode(currentWeather, forKey: #keyPath(currentWeather))
        coder.encode(dailyForecast, forKey: #keyPath(dailyForecast))
        coder.encode(hourlyForecast, forKey: #keyPath(hourlyForecast))
        coder.encode(minuteForecast, forKey: #keyPath(minuteForecast))
        coder.encode(weatherAlerts, forKey: #keyPath(weatherAlerts))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPWeather(
            availability: availability,
            currentWeather: currentWeather,
            dailyForecast: dailyForecast,
            hourlyForecast: hourlyForecast,
            minuteForecast: minuteForecast,
            weatherAlerts: weatherAlerts
        )
    }
}