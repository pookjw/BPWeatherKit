import WeatherKit

@objc public enum BPPrecipitation: Int, Sendable {
    // No precipitation.
    case none

    /// A form of precipitation consisting of solid ice.
    case hail

    /// Mixed precipitation.
    case mixed

    /// Rain.
    case rain

    /// A form of precipitation consisting of ice pellets.
    case sleet

    /// Snow.
    case snow
    
    public init(precipitation: Precipitation) {
        switch precipitation {
        case .none:
            self = .none
        case .hail:
            self = .hail
        case .mixed:
            self = .mixed
        case .rain:
            self = .rain
        case .sleet:
            self = .sleet
        case .snow:
            self = .snow
        @unknown default:
            fatalError()
        }
    }
    
    fileprivate var precipitation: Precipitation {
        switch self {
        case .none:
            return .none
        case .hail:
            return .hail
        case .mixed:
            return .mixed
        case .rain:
            return .rain
        case .sleet:
            return .sleet
        case .snow:
            return .snow
        }
    }
}

@_cdecl("BPPrecipitation_accessibilityDescription") public func BPPrecipitation_accessibilityDescription(rawValue: Int) -> String? {
    BPPrecipitation(rawValue: rawValue)?.precipitation.accessibilityDescription
}

@_cdecl("BPPrecipitation_description") public func BPPrecipitation_description(rawValue: Int) -> String? {
    BPPrecipitation(rawValue: rawValue)?.precipitation.description
}
