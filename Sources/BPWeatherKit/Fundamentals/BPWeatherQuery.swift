import Foundation
import WeatherKit

@objcMembers open class BPWeatherQuery: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    internal enum WeatherQuery: Hashable {
        case current
        case minute
        case hourly
        case daily
        case alerts
        case availability
        case _daily(startDate: Date!, endDate: Date!)
        case _hourly(startDate: Date!, endDate: Date!)
        
        var typeValue: Int {
            switch self {
            case .current:
                return .zero
            case .minute:
                return 1
            case .hourly:
                return 2
            case .daily:
                return 3
            case .alerts:
                return 4
            case .availability:
                return 5
            case ._daily:
                return 6
            case ._hourly:
                return 7
            }
        }
    }
    
    public static let supportsSecureCoding: Bool = true
    
    public static var current: BPWeatherQuery {
        .init(weatherQuery: .current)
    }
    
    public static var minute: BPWeatherQuery {
        .init(weatherQuery: .minute)
    }
    
    public static var hourly: BPWeatherQuery {
        .init(weatherQuery: .hourly)
    }
    
    public static var daily: BPWeatherQuery {
        .init(weatherQuery: .daily)
    }
    
    public static var alerts: BPWeatherQuery {
        .init(weatherQuery: .alerts)
    }
    
    public static var availability: BPWeatherQuery {
        .init(weatherQuery: .availability)
    }
    
    public static func daily(startDate: Date, endDate: Date) -> BPWeatherQuery {
        .init(weatherQuery: ._daily(startDate: startDate, endDate: endDate))
    }
    
    public static func hourly(startDate: Date, endDate: Date) -> BPWeatherQuery {
        .init(weatherQuery: ._hourly(startDate: startDate, endDate: endDate))
    }
    
    private static let weatherQueryTypeKey: String = "weatherQueryTypeKey"
    private static let weatherQueryStartDateKey: String = "weatherQueryStartDateKey"
    private static let weatherQueryEndDateKey: String = "weatherQueryEndDateKey"
    
    internal let weatherQuery: WeatherQuery
    
    public required convenience init?(coder: NSCoder) {
        let weatherQueryTypeValue: Int = coder.decodeInteger(forKey: Self.weatherQueryTypeKey)
        let weatherQuery: WeatherQuery
        
        switch weatherQueryTypeValue {
        case WeatherQuery.current.typeValue:
            weatherQuery = .current
        case WeatherQuery.minute.typeValue:
            weatherQuery = .minute
        case WeatherQuery.hourly.typeValue:
            weatherQuery = .hourly
        case WeatherQuery.daily.typeValue:
            weatherQuery = .daily
        case WeatherQuery.alerts.typeValue:
            weatherQuery = .alerts
        case WeatherQuery.availability.typeValue:
            weatherQuery = .availability
        case WeatherQuery._daily(startDate: nil, endDate: nil).typeValue:
            guard
                let startDate: Date = coder.decodeObject(forKey: Self.weatherQueryStartDateKey) as? Date,
                let endDate: Date = coder.decodeObject(forKey: Self.weatherQueryEndDateKey) as? Date
            else {
                return nil
            }
            
            weatherQuery = ._daily(startDate: startDate, endDate: endDate)
        case WeatherQuery._hourly(startDate: nil, endDate: nil).typeValue:
            guard
                let startDate: Date = coder.decodeObject(forKey: Self.weatherQueryStartDateKey) as? Date,
                let endDate: Date = coder.decodeObject(forKey: Self.weatherQueryEndDateKey) as? Date
            else {
                return nil
            }
            
            weatherQuery = ._hourly(startDate: startDate, endDate: endDate)
        default:
            return nil
        }
        
        self.init(weatherQuery: weatherQuery)
    }
    
    @nonobjc private init(weatherQuery: WeatherQuery) {
        self.weatherQuery = weatherQuery
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(weatherQuery.typeValue, forKey: Self.weatherQueryTypeKey)
        
        switch weatherQuery {
        case .current:
            break
        case .minute:
            break
        case .hourly:
            break
        case .daily:
            break
        case .alerts:
            break
        case .availability:
            break
        case ._daily(let startDate, let endDate):
            coder.encode(startDate, forKey: Self.weatherQueryStartDateKey)
            coder.encode(endDate, forKey: Self.weatherQueryEndDateKey)
        case ._hourly(let startDate, let endDate):
            coder.encode(startDate, forKey: Self.weatherQueryStartDateKey)
            coder.encode(endDate, forKey: Self.weatherQueryEndDateKey)
        }
    }
    
        open func copy(with zone: NSZone? = nil) -> Any {
        switch weatherQuery {
        case .current:
            return Self.current
        case .minute:
            return Self.minute
        case .hourly:
            return Self.hourly
        case .daily:
            return Self.daily
        case .alerts:
            return Self.alerts
        case .availability:
            return Self.availability
        case ._daily(let startDate, let endDate):
            return Self.daily(startDate: startDate!, endDate: endDate!)
        case ._hourly(let startDate, let endDate):
            return Self.hourly(startDate: startDate!, endDate: endDate!)
        }
    }
}
