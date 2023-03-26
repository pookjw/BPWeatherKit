import WeatherKit

@objc public enum BPWeatherSeverity: Int, Sendable {
    /// Minimal or no known threat.
    case minor

    /// Possible threat.
    case moderate

    /// Significant threat.
    case severe

    /// Extraordinary threat.
    case extreme

    /// Unknown threat.
    case unknown
    
    public init(weatherSeverity: WeatherSeverity) {
        switch weatherSeverity {
        case .minor:
            self = .minor
        case .moderate:
            self = .moderate
        case .severe:
            self = .severe
        case .extreme:
            self = .extreme
        case .unknown:
            self = .unknown
        @unknown default:
            fatalError()
        }
    }
    
    fileprivate var weatherSeverity: WeatherSeverity {
        switch self {
        case .minor:
            return .minor
        case .moderate:
            return .moderate
        case .severe:
            return .severe
        case .extreme:
            return .extreme
        case .unknown:
            return .unknown
        }
    }
}

@_cdecl("BPWeatherSeverity_accessibilityDescription") public func BPWeatherSeverity_accessibilityDescription(rawValue: BPWeatherSeverity.RawValue) -> String? {
    BPWeatherSeverity(rawValue: rawValue)?.weatherSeverity.accessibilityDescription
}

@_cdecl("BPWeatherSeverity_description") public func BPWeatherSeverity_description(rawValue: BPWeatherSeverity.RawValue) -> String? {
    BPWeatherSeverity(rawValue: rawValue)?.weatherSeverity.description
}
