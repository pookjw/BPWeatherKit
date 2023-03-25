import WeatherKit

@objc public enum BPPressureTrend: Int, Sendable {
    case falling
    case rising
    case steady
    
    public init(pressureTrend: PressureTrend) {
        switch pressureTrend {
        case .rising:
            self = .rising
        case .falling:
            self = .falling
        case .steady:
            self = .steady
        @unknown default:
            fatalError()
        }
    }
    
    fileprivate var pressureTrend: PressureTrend {
        switch self {
        case .falling:
            return .falling
        case .rising:
            return .rising
        case .steady:
            return .steady
        }
    }
}

@_cdecl("BPPressureTrend_accessibilityDescription") public func BPPressureTrend_accessibilityDescription(rawValue: BPPressureTrend.RawValue) -> String? {
    BPPressureTrend(rawValue: rawValue)?.pressureTrend.accessibilityDescription
}

@_cdecl("BPPressureTrend_description") public func BPPressureTrend_description(rawValue: BPPressureTrend.RawValue) -> String? {
    BPPressureTrend(rawValue: rawValue)?.pressureTrend.description
}
