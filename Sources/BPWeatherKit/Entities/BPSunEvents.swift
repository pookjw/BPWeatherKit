import Foundation
import WeatherKit

@objcMembers open class BPSunEvents: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let astronomicalDawn: Date?
    public let astronomicalDusk: Date?
    public let civilDawn: Date?
    public let civilDusk: Date?
    public let nauticalDawn: Date?
    public let nauticalDusk: Date?
    public let solarMidnight: Date?
    public let solarNoon: Date?
    public let sunrise: Date?
    public let sunset: Date?
    
    public required convenience init?(coder: NSCoder) {
        let astronomicalDawn: Date? = coder.decodeObject(forKey: #keyPath(astronomicalDawn)) as? Date
        let astronomicalDusk: Date? = coder.decodeObject(forKey: #keyPath(astronomicalDusk)) as? Date
        let civilDawn: Date? = coder.decodeObject(forKey: #keyPath(civilDawn)) as? Date
        let civilDusk: Date? = coder.decodeObject(forKey: #keyPath(civilDusk)) as? Date
        let nauticalDawn: Date? = coder.decodeObject(forKey: #keyPath(nauticalDawn)) as? Date
        let nauticalDusk: Date? = coder.decodeObject(forKey: #keyPath(nauticalDusk)) as? Date
        let solarMidnight: Date? = coder.decodeObject(forKey: #keyPath(solarMidnight)) as? Date
        let solarNoon: Date? = coder.decodeObject(forKey: #keyPath(solarNoon)) as? Date
        let sunrise: Date? = coder.decodeObject(forKey: #keyPath(sunrise)) as? Date
        let sunset: Date? = coder.decodeObject(forKey: #keyPath(sunset)) as? Date
        
        self.init(
            astronomicalDawn: astronomicalDawn,
            astronomicalDusk: astronomicalDusk,
            civilDawn: civilDawn,
            civilDusk: civilDusk,
            nauticalDawn: nauticalDawn,
            nauticalDusk: nauticalDusk,
            solarMidnight: solarMidnight,
            solarNoon: solarNoon,
            sunrise: sunrise,
            sunset: sunset
        )
    }
    
    @nonobjc public convenience init(sunEvents: SunEvents) {
        self.init(
            astronomicalDawn: sunEvents.astronomicalDawn,
            astronomicalDusk: sunEvents.astronomicalDusk,
            civilDawn: sunEvents.civilDawn,
            civilDusk: sunEvents.civilDusk,
            nauticalDawn: sunEvents.nauticalDawn,
            nauticalDusk: sunEvents.nauticalDusk,
            solarMidnight: sunEvents.solarMidnight,
            solarNoon: sunEvents.solarNoon,
            sunrise: sunEvents.sunrise,
            sunset: sunEvents.sunset
        )
    }
    
    @nonobjc private init(
        astronomicalDawn: Date?,
        astronomicalDusk: Date?,
        civilDawn: Date?,
        civilDusk: Date?,
        nauticalDawn: Date?,
        nauticalDusk: Date?,
        solarMidnight: Date?,
        solarNoon: Date?,
        sunrise: Date?,
        sunset: Date?
    ) {
        self.astronomicalDawn = astronomicalDawn
        self.astronomicalDusk = astronomicalDusk
        self.civilDawn = civilDawn
        self.civilDusk = civilDusk
        self.nauticalDawn = nauticalDawn
        self.nauticalDusk = nauticalDusk
        self.solarMidnight = solarMidnight
        self.solarNoon = solarNoon
        self.sunrise = sunrise
        self.sunset = sunset
        
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(astronomicalDawn, forKey: #keyPath(astronomicalDawn))
        coder.encode(astronomicalDusk, forKey: #keyPath(astronomicalDusk))
        coder.encode(civilDawn, forKey: #keyPath(civilDawn))
        coder.encode(civilDusk, forKey: #keyPath(civilDusk))
        coder.encode(nauticalDawn, forKey: #keyPath(nauticalDawn))
        coder.encode(nauticalDusk, forKey: #keyPath(nauticalDusk))
        coder.encode(solarMidnight, forKey: #keyPath(solarMidnight))
        coder.encode(solarNoon, forKey: #keyPath(solarNoon))
        coder.encode(sunrise, forKey: #keyPath(sunrise))
        coder.encode(sunset, forKey: #keyPath(sunset))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPSunEvents(
            astronomicalDawn: astronomicalDawn,
            astronomicalDusk: astronomicalDusk,
            civilDawn: civilDawn,
            civilDusk: civilDusk,
            nauticalDawn: nauticalDawn,
            nauticalDusk: nauticalDusk,
            solarMidnight: solarMidnight,
            solarNoon: solarNoon,
            sunrise: sunrise,
            sunset: sunset
        )
    }
}
