import Foundation
import WeatherKit

@objcMembers open class BPHourWeather: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let apparentTemperature: Measurement<UnitTemperature>
    public let humidity: Double
    public let temperature: Measurement<UnitTemperature>
    public let dewPoint: Measurement<UnitTemperature>
    public let pressure: Measurement<UnitPressure>
    public let pressureTrend: BPPressureTrend
    public let cloudCover: Double
    public let condition: BPWeatherCondition
    public let isDaylight: Bool
    public let visibility: Measurement<UnitLength>
    public let uvIndex: BPUVIndex
    public let wind: BPWind
    public let date: Date
    public let precipitation: BPPrecipitation
    public let precipitationChance: Double
    public let precipitationAmount: Measurement<UnitLength>
    public let symbolName: String
    
    public required convenience init?(coder: NSCoder) {
        let pressureTrendRawValue: BPPressureTrend.RawValue = coder.decodeInteger(forKey: #keyPath(pressureTrend))
        let conditionRawValue: BPWeatherCondition.RawValue = coder.decodeInteger(forKey: #keyPath(condition))
        let precipitationRawValue: BPPrecipitation.RawValue = coder.decodeInteger(forKey: #keyPath(precipitation))
        
        guard
            let apparentTemperature: Measurement<UnitTemperature> = coder.decodeObject(forKey: #keyPath(apparentTemperature)) as? Measurement<UnitTemperature>,
            let temperature: Measurement<UnitTemperature> = coder.decodeObject(forKey: #keyPath(temperature)) as? Measurement<UnitTemperature>,
            let dewPoint: Measurement<UnitTemperature> = coder.decodeObject(forKey: #keyPath(dewPoint)) as? Measurement<UnitTemperature>,
            let pressure: Measurement<UnitPressure> = coder.decodeObject(forKey: #keyPath(pressure)) as? Measurement<UnitPressure>,
            let pressureTrend: BPPressureTrend = .init(rawValue: pressureTrendRawValue),
            let condition: BPWeatherCondition = .init(rawValue: conditionRawValue),
            let visibility: Measurement<UnitLength> = coder.decodeObject(forKey: #keyPath(visibility)) as? Measurement<UnitLength>,
            let uvIndex: BPUVIndex = coder.decodeObject(forKey: #keyPath(uvIndex)) as? BPUVIndex,
            let wind: BPWind = coder.decodeObject(forKey: #keyPath(wind)) as? BPWind,
            let date: Date = coder.decodeObject(forKey: #keyPath(date)) as? Date,
            let precipitation: BPPrecipitation = .init(rawValue: precipitationRawValue),
            let precipitationAmount: Measurement<UnitLength> = coder.decodeObject(forKey: #keyPath(precipitationAmount)) as? Measurement<UnitLength>,
            let symbolName: String = coder.decodeObject(forKey: #keyPath(symbolName)) as? String
        else {
            return nil
        }
        
        let humidity: Double = coder.decodeDouble(forKey: #keyPath(humidity))
        let cloudCover: Double = coder.decodeDouble(forKey: #keyPath(cloudCover))
        let isDaylight: Bool = coder.decodeBool(forKey: #keyPath(isDaylight))
        let precipitationChance: Double = coder.decodeDouble(forKey: #keyPath(precipitationChance))
        
        self.init(
            apparentTemperature: apparentTemperature,
            humidity: humidity,
            temperature: temperature,
            dewPoint: dewPoint,
            pressure: pressure,
            pressureTrend: pressureTrend,
            cloudCover: cloudCover,
            condition: condition,
            isDaylight: isDaylight,
            visibility: visibility,
            uvIndex: uvIndex,
            wind: wind,
            date: date,
            precipitation: precipitation,
            precipitationChance: precipitationChance,
            precipitationAmount: precipitationAmount,
            symbolName: symbolName
        )
    }
    
    @nonobjc public convenience init(hourWeather: HourWeather) {
        self.init(
            apparentTemperature: hourWeather.apparentTemperature,
            humidity: hourWeather.humidity,
            temperature: hourWeather.temperature,
            dewPoint: hourWeather.dewPoint,
            pressure: hourWeather.pressure,
            pressureTrend: .init(pressureTrend: hourWeather.pressureTrend),
            cloudCover: hourWeather.cloudCover,
            condition: .init(weatherCondition: hourWeather.condition),
            isDaylight: hourWeather.isDaylight,
            visibility: hourWeather.visibility,
            uvIndex: .init(uvIndex: hourWeather.uvIndex),
            wind: .init(wind: hourWeather.wind),
            date: hourWeather.date,
            precipitation: .init(precipitation: hourWeather.precipitation),
            precipitationChance: hourWeather.precipitationChance,
            precipitationAmount: hourWeather.precipitationAmount,
            symbolName: hourWeather.symbolName
        )
    }
    
    @nonobjc private init(
        apparentTemperature: Measurement<UnitTemperature>,
        humidity: Double,
        temperature: Measurement<UnitTemperature>,
        dewPoint: Measurement<UnitTemperature>,
        pressure: Measurement<UnitPressure>,
        pressureTrend: BPPressureTrend,
        cloudCover: Double,
        condition: BPWeatherCondition,
        isDaylight: Bool,
        visibility: Measurement<UnitLength>,
        uvIndex: BPUVIndex,
        wind: BPWind,
        date: Date,
        precipitation: BPPrecipitation,
        precipitationChance: Double,
        precipitationAmount: Measurement<UnitLength>,
        symbolName: String
    ) {
        self.apparentTemperature = apparentTemperature
        self.humidity = humidity
        self.temperature = temperature
        self.dewPoint = dewPoint
        self.pressure = pressure
        self.pressureTrend = pressureTrend
        self.cloudCover = cloudCover
        self.condition = condition
        self.isDaylight = isDaylight
        self.visibility = visibility
        self.uvIndex = uvIndex
        self.wind = wind
        self.date = date
        self.precipitation = precipitation
        self.precipitationChance = precipitationChance
        self.precipitationAmount = precipitationAmount
        self.symbolName = symbolName
        
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(apparentTemperature, forKey: #keyPath(apparentTemperature))
        coder.encode(humidity, forKey: #keyPath(humidity))
        coder.encode(temperature, forKey: #keyPath(temperature))
        coder.encode(dewPoint, forKey: #keyPath(dewPoint))
        coder.encode(pressure, forKey: #keyPath(pressure))
        coder.encode(pressureTrend, forKey: #keyPath(pressureTrend))
        coder.encode(cloudCover, forKey: #keyPath(cloudCover))
        coder.encode(condition, forKey: #keyPath(condition))
        coder.encode(isDaylight, forKey: #keyPath(isDaylight))
        coder.encode(visibility, forKey: #keyPath(visibility))
        coder.encode(uvIndex, forKey: #keyPath(uvIndex))
        coder.encode(wind, forKey: #keyPath(wind))
        coder.encode(date, forKey: #keyPath(date))
        coder.encode(precipitation, forKey: #keyPath(precipitation))
        coder.encode(precipitationChance, forKey: #keyPath(precipitationChance))
        coder.encode(precipitationAmount, forKey: #keyPath(precipitationAmount))
        coder.encode(symbolName, forKey: #keyPath(symbolName))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPHourWeather(
            apparentTemperature: apparentTemperature,
            humidity: humidity,
            temperature: temperature,
            dewPoint: dewPoint,
            pressure: pressure,
            pressureTrend: pressureTrend,
            cloudCover: cloudCover,
            condition: condition,
            isDaylight: isDaylight,
            visibility: visibility,
            uvIndex: uvIndex.copy() as! BPUVIndex,
            wind: wind.copy() as! BPWind,
            date: date,
            precipitation: precipitation,
            precipitationChance: precipitationChance,
            precipitationAmount: precipitationAmount,
            symbolName: symbolName
        )
    }
}
