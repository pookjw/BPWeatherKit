import Foundation
import WeatherKit

@objcMembers open class BPWind: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    @objc(BPWindCompassDirection) public enum CompassDirection: Int, Sendable {
        case north
        case northNortheast
        case northeast
        case eastNortheast
        case east
        case eastSoutheast
        case southeast
        case southSoutheast
        case south
        case southSouthwest
        case southwest
        case westSouthwest
        case west
        case westNorthwest
        case northwest
        case northNorthwest
        
        public init(compassDirection: Wind.CompassDirection) {
            switch compassDirection {
            case .north:
                self = .north
            case .northNortheast:
                self = .northNortheast
            case .northeast:
                self = .northeast
            case .eastNortheast:
                self = .eastNortheast
            case .east:
                self = .east
            case .eastSoutheast:
                self = .eastSoutheast
            case .southeast:
                self = .southeast
            case .southSoutheast:
                self = .southSoutheast
            case .south:
                self = .south
            case .southSouthwest:
                self = .southSouthwest
            case .southwest:
                self = .southwest
            case .westSouthwest:
                self = .westSouthwest
            case .west:
                self = .west
            case .westNorthwest:
                self = .westNorthwest
            case .northwest:
                self = .northwest
            case .northNorthwest:
                self = .northNorthwest
            }
        }
        
        fileprivate var compassDirection: Wind.CompassDirection {
            switch self {
            case .north:
                return .north
            case .northNortheast:
                return .northNortheast
            case .northeast:
                return .northeast
            case .eastNortheast:
                return .eastNortheast
            case .east:
                return .east
            case .eastSoutheast:
                return .eastSoutheast
            case .southeast:
                return .southeast
            case .southSoutheast:
                return .southSoutheast
            case .south:
                return .south
            case .southSouthwest:
                return .southSouthwest
            case .southwest:
                return .southwest
            case .westSouthwest:
                return .westSouthwest
            case .west:
                return .west
            case .westNorthwest:
                return .westNorthwest
            case .northwest:
                return .northwest
            case .northNorthwest:
                return .northNorthwest
            }
        }
    }
    
    public let compassDirection: CompassDirection
    public let direction: Measurement<UnitAngle>
    public let gust: Measurement<UnitSpeed>?
    public let speed: Measurement<UnitSpeed>
    
    open override var hash: Int {
        var hasher: Hasher = .init()
        
        hasher.combine(compassDirection)
        hasher.combine(direction)
        hasher.combine(gust)
        hasher.combine(speed)
        
        return hasher.finalize()
    }
    
    public required convenience init?(coder: NSCoder) {
        let compassDirectionRawValue: CompassDirection.RawValue = coder.decodeInteger(forKey: #keyPath(compassDirection))
        
        guard
            let compassDirection: CompassDirection = .init(rawValue: compassDirectionRawValue),
            let direction: Measurement<UnitAngle> = coder.decodeObject(forKey: #keyPath(direction)) as? Measurement<UnitAngle>,
            let speed: Measurement<UnitSpeed> = coder.decodeObject(forKey: #keyPath(speed)) as? Measurement<UnitSpeed>
        else {
            return nil
        }
        
        let gust: Measurement<UnitSpeed>? = coder.decodeObject(forKey: #keyPath(gust)) as? Measurement<UnitSpeed>
        
        self.init(
            compassDirection: compassDirection,
            direction: direction,
            gust: gust,
            speed: speed
        )
    }
    
    @nonobjc public convenience init(wind: Wind) {
        self.init(
            compassDirection: .init(compassDirection: wind.compassDirection),
            direction: wind.direction,
            gust: wind.gust,
            speed: wind.speed
        )
    }
    
    @nonobjc private init(
        compassDirection: CompassDirection,
        direction: Measurement<UnitAngle>,
        gust: Measurement<UnitSpeed>?,
        speed: Measurement<UnitSpeed>
    ) {
        self.compassDirection = compassDirection
        self.direction = direction
        self.gust = gust
        self.speed = speed
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(compassDirection.rawValue, forKey: #keyPath(compassDirection))
        coder.encode(direction, forKey: #keyPath(direction))
        coder.encode(gust, forKey: #keyPath(gust))
        coder.encode(speed, forKey: #keyPath(speed))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPWind(
            compassDirection: compassDirection,
            direction: direction,
            gust: gust,
            speed: speed
        )
    }
    
    open override func isEqual(_ object: Any?) -> Bool {
        guard let other: BPWind = object as? BPWind else {
            return super.isEqual(object)
        }
        
        return compassDirection == other.compassDirection &&
        direction == other.direction &&
        gust == other.gust &&
        speed == other.speed
    }
}

@_cdecl("BPWindCompassDirection_abbreviation") public func BPWindCompassDirection_abbreviation(rawValue: Int) -> String? {
    BPWind.CompassDirection(rawValue: rawValue)?.compassDirection.abbreviation
}

@_cdecl("BPWindCompassDirection_accessibilityDescription") public func BPWindCompassDirection_accessibilityDescription(rawValue: Int) -> String? {
    BPWind.CompassDirection(rawValue: rawValue)?.compassDirection.accessibilityDescription
}

@_cdecl("BPWindCompassDirection_description") public func BPWindCompassDirection_description(rawValue: Int) -> String? {
    BPWind.CompassDirection(rawValue: rawValue)?.compassDirection.description
}
