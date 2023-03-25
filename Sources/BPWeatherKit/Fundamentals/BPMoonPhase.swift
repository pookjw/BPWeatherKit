import WeatherKit

@objc public enum BPMoonPhase: Int, Sendable {
    /// The disk is unlit where the moon is not visible.
    case new

    /// The disk is partially lit as the moon is waxing.
    case waxingCrescent

    /// The disk is half lit.
    case firstQuarter

    /// The disk is half lit as the moon is waxing.
    case waxingGibbous

    /// The disk is fully lit where the moon is visible.
    case full

    /// The disk is half lit as the moon is waning.
    case waningGibbous

    /// The disk is half lit.
    case lastQuarter

    /// The disk is partially lit as the moon is waning.
    case waningCrescent
    
    public init(moonPhase: MoonPhase) {
        switch moonPhase {
        case .new:
            self = .new
        case .waxingCrescent:
            self = .waxingCrescent
        case .firstQuarter:
            self = .firstQuarter
        case .waxingGibbous:
            self = .waxingGibbous
        case .full:
            self = .full
        case .waningGibbous:
            self = .waningGibbous
        case .lastQuarter:
            self = .lastQuarter
        case .waningCrescent:
            self = .waningCrescent
        }
    }
    
    fileprivate var moonPhase: MoonPhase {
        switch self {
        case .new:
            return .new
        case .waxingCrescent:
            return .waxingCrescent
        case .firstQuarter:
            return .firstQuarter
        case .waxingGibbous:
            return .waxingGibbous
        case .full:
            return .full
        case .waningGibbous:
            return .waningGibbous
        case .lastQuarter:
            return .lastQuarter
        case .waningCrescent:
            return .waningCrescent
        }
    }
}

@_cdecl("BPMoonPhase_accessibilityDescription") public func BPMoonPhase_accessibilityDescription(rawValue: BPMoonPhase.RawValue) -> String? {
    BPMoonPhase(rawValue: rawValue)?.moonPhase.accessibilityDescription
}

@_cdecl("BPMoonPhase_description") public func BPMoonPhase_description(rawValue: BPMoonPhase.RawValue) -> String? {
    BPMoonPhase(rawValue: rawValue)?.moonPhase.description
}

@_cdecl("BPMoonPhase_symbolName") public func BPMoonPhase_symbolName(rawValue: BPMoonPhase.RawValue) -> String? {
    BPMoonPhase(rawValue: rawValue)?.moonPhase.symbolName
}
