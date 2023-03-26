import Foundation
import WeatherKit

@objcMembers open class BPMinuteWeather: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let precipitation: BPPrecipitation
    public let precipitationChance: Double
    public let precipitationIntensity: Measurement<UnitSpeed>
    public let date: Date
    
    public required convenience init?(coder: NSCoder) {
        let precipitationRawValue: BPPrecipitation.RawValue = coder.decodeInteger(forKey: #keyPath(precipitation))
        
        guard
            let precipitation: BPPrecipitation = .init(rawValue: precipitationRawValue),
            let precipitationIntensity: Measurement<UnitSpeed> = coder.decodeObject(forKey: #keyPath(precipitationIntensity)) as? Measurement<UnitSpeed>,
            let date: Date = coder.decodeObject(forKey: #keyPath(date)) as? Date
        else {
            return nil
        }
        
        
        let precipitationChance: Double = coder.decodeDouble(forKey: #keyPath(precipitationChance))
        
        self.init(
            precipitation: precipitation,
            precipitationChance: precipitationChance,
            precipitationIntensity: precipitationIntensity,
            date: date
        )
    }
    
    @nonobjc public convenience init(minuteWeather: MinuteWeather) {
        self.init(
            precipitation: .init(precipitation: minuteWeather.precipitation),
            precipitationChance: minuteWeather.precipitationChance,
            precipitationIntensity: minuteWeather.precipitationIntensity,
            date: minuteWeather.date
        )
    }
    
    @nonobjc private init(
        precipitation: BPPrecipitation,
        precipitationChance: Double,
        precipitationIntensity: Measurement<UnitSpeed>,
        date: Date
    ) {
        self.precipitation = precipitation
        self.precipitationChance = precipitationChance
        self.precipitationIntensity = precipitationIntensity
        self.date = date
        
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(precipitation, forKey: #keyPath(precipitation))
        coder.encode(precipitationChance, forKey: #keyPath(precipitationChance))
        coder.encode(precipitationIntensity, forKey: #keyPath(precipitationIntensity))
        coder.encode(date, forKey: #keyPath(date))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPMinuteWeather(
            precipitation: precipitation,
            precipitationChance: precipitationChance,
            precipitationIntensity: precipitationIntensity,
            date: date
        )
    }
}
