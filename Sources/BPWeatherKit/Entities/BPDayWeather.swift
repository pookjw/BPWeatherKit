import Foundation
import WeatherKit

@objcMembers open class BPDayWeather: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let highTemperature: Measurement<UnitTemperature>
    public let lowTemperature: Measurement<UnitTemperature>
    public let precipitation: BPPrecipitation
    public let precipitationChance: Double
    public let precipitationAmount: Measurement<UnitLength>
    public let snowfallAmount: Measurement<UnitLength>
    public let moon: BPMoonEvents
    public let sun: BPSunEvents
    public let wind: BPWind
    public let date: Date
    public let condition: BPWeatherCondition
    public let uvIndex: BPUVIndex
    public let symbolName: String
    
    public required convenience init?(coder: NSCoder) {
        let conditionRawValue: BPWeatherCondition.RawValue = coder.decodeInteger(forKey: #keyPath(condition))
        
        guard
            let highTemperature: Measurement<UnitTemperature> = coder.decodeObject(forKey: #keyPath(highTemperature)) as? Measurement<UnitTemperature>,
            let lowTemperature: Measurement<UnitTemperature> = coder.decodeObject(forKey: #keyPath(lowTemperature)) as? Measurement<UnitTemperature>,
            let precipitation: BPPrecipitation = coder.decodeObject(forKey: #keyPath(precipitation)) as? BPPrecipitation,
            let precipitationAmount: Measurement<UnitLength> = coder.decodeObject(forKey: #keyPath(precipitationAmount)) as? Measurement<UnitLength>,
            let snowfallAmount: Measurement<UnitLength> = coder.decodeObject(forKey: #keyPath(snowfallAmount)) as? Measurement<UnitLength>,
            let moon: BPMoonEvents = coder.decodeObject(forKey: #keyPath(moon)) as? BPMoonEvents,
            let sun: BPSunEvents = coder.decodeObject(forKey: #keyPath(sun)) as? BPSunEvents,
            let wind: BPWind = coder.decodeObject(forKey: #keyPath(wind)) as? BPWind,
            let date: Date = coder.decodeObject(forKey: #keyPath(date)) as? Date,
            let condition: BPWeatherCondition = .init(rawValue: conditionRawValue),
            let uvIndex: BPUVIndex = coder.decodeObject(forKey: #keyPath(uvIndex)) as? BPUVIndex,
            let symbolName: String = coder.decodeObject(forKey: #keyPath(symbolName)) as? String
        else {
            return nil
        }
        
        let precipitationChance: Double = coder.decodeDouble(forKey: #keyPath(precipitationChance))
        
        self.init(
            highTemperature: highTemperature,
            lowTemperature: lowTemperature,
            precipitation: precipitation,
            precipitationChance: precipitationChance,
            precipitationAmount: precipitationAmount,
            snowfallAmount: snowfallAmount,
            moon: moon,
            sun: sun,
            wind: wind,
            date: date,
            condition: condition,
            uvIndex: uvIndex,
            symbolName: symbolName
        )
    }
    
    @nonobjc public convenience init(dayWeather: DayWeather) {
        self.init(
            highTemperature: dayWeather.highTemperature,
            lowTemperature: dayWeather.lowTemperature,
            precipitation: .init(precipitation: dayWeather.precipitation),
            precipitationChance: dayWeather.precipitationChance,
            precipitationAmount: dayWeather.precipitationAmount,
            snowfallAmount: dayWeather.snowfallAmount,
            moon: .init(moonEvents: dayWeather.moon),
            sun: .init(sunEvents: dayWeather.sun),
            wind: .init(wind: dayWeather.wind),
            date: dayWeather.date,
            condition: .init(weatherCondition: dayWeather.condition),
            uvIndex: .init(uvIndex: dayWeather.uvIndex),
            symbolName: dayWeather.symbolName
        )
    }
    
    @nonobjc private init(
        highTemperature: Measurement<UnitTemperature>,
        lowTemperature: Measurement<UnitTemperature>,
        precipitation: BPPrecipitation,
        precipitationChance: Double,
        precipitationAmount: Measurement<UnitLength>,
        snowfallAmount: Measurement<UnitLength>,
        moon: BPMoonEvents,
        sun: BPSunEvents,
        wind: BPWind,
        date: Date,
        condition: BPWeatherCondition,
        uvIndex: BPUVIndex,
        symbolName: String
    ) {
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.precipitation = precipitation
        self.precipitationChance = precipitationChance
        self.precipitationAmount = precipitationAmount
        self.snowfallAmount = snowfallAmount
        self.moon = moon
        self.sun = sun
        self.wind = wind
        self.date = date
        self.condition = condition
        self.uvIndex = uvIndex
        self.symbolName = symbolName
        
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(highTemperature, forKey: #keyPath(highTemperature))
        coder.encode(lowTemperature, forKey: #keyPath(lowTemperature))
        coder.encode(precipitation, forKey: #keyPath(precipitation))
        coder.encode(precipitationChance, forKey: #keyPath(precipitationChance))
        coder.encode(precipitationAmount, forKey: #keyPath(precipitationAmount))
        coder.encode(snowfallAmount, forKey: #keyPath(snowfallAmount))
        coder.encode(moon, forKey: #keyPath(moon))
        coder.encode(sun, forKey: #keyPath(sun))
        coder.encode(wind, forKey: #keyPath(wind))
        coder.encode(date, forKey: #keyPath(date))
        coder.encode(condition.rawValue, forKey: #keyPath(condition))
        coder.encode(uvIndex, forKey: #keyPath(uvIndex))
        coder.encode(symbolName, forKey: #keyPath(symbolName))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPDayWeather(
            highTemperature: highTemperature,
            lowTemperature: lowTemperature,
            precipitation: precipitation,
            precipitationChance: precipitationChance,
            precipitationAmount:precipitationAmount,
            snowfallAmount: snowfallAmount,
            moon: moon.copy() as! BPMoonEvents,
            sun: sun.copy() as! BPSunEvents,
            wind: wind.copy() as! BPWind,
            date: date,
            condition: condition,
            uvIndex: uvIndex.copy() as! BPUVIndex,
            symbolName: symbolName
        )
    }
}
