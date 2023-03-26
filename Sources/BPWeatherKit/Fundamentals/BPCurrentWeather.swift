import Foundation
import WeatherKit

@objcMembers open class BPCurrentWeather: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let apparentTemperature: Measurement<UnitTemperature>
    public let dewPoint: Measurement<UnitTemperature>
    public let humidity: Double
    public let temperature: Measurement<UnitTemperature>
    public let pressure: Measurement<UnitPressure>
    public let pressureTrend: BPPressureTrend
    public let wind: BPWind
    public let cloudCover: Double
    public let condition: BPWeatherCondition
    public let date: Date
    public let isDaylight: Bool
    public let uvIndex: BPUVIndex
    public let visibility: Measurement<UnitLength>
    public let metadata: BPWeatherMetadata
    public let symbolName: String
    
    public required convenience init?(coder: NSCoder) {
        let pressureTrendRawValue: BPPressureTrend.RawValue = coder.decodeInteger(forKey: #keyPath(pressureTrend))
        let conditionRawValue: BPWeatherCondition.RawValue = coder.decodeInteger(forKey: #keyPath(condition))
        
        guard
            let apparentTemperature: Measurement<UnitTemperature> = coder.decodeObject(forKey: #keyPath(apparentTemperature)) as? Measurement<UnitTemperature>,
            let dewPoint: Measurement<UnitTemperature> = coder.decodeObject(forKey: #keyPath(dewPoint)) as? Measurement<UnitTemperature>,
            let temperature: Measurement<UnitTemperature> = coder.decodeObject(forKey: #keyPath(temperature)) as? Measurement<UnitTemperature>,
            let pressure: Measurement<UnitPressure> = coder.decodeObject(forKey: #keyPath(pressure)) as? Measurement<UnitPressure>,
            let pressureTrend: BPPressureTrend = .init(rawValue: pressureTrendRawValue),
            let wind: BPWind = coder.decodeObject(forKey: #keyPath(wind)) as? BPWind,
            let condition: BPWeatherCondition = .init(rawValue: conditionRawValue),
            let date: Date = coder.decodeObject(forKey: #keyPath(date)) as? Date,
            let uvIndex: BPUVIndex = coder.decodeObject(forKey: #keyPath(uvIndex)) as? BPUVIndex,
            let visibility: Measurement<UnitLength> = coder.decodeObject(forKey: #keyPath(visibility)) as? Measurement<UnitLength>,
            let metadata: BPWeatherMetadata = coder.decodeObject(forKey: #keyPath(metadata)) as? BPWeatherMetadata,
            let symbolName: String = coder.decodeObject(forKey: #keyPath(symbolName)) as? String
        else {
            return nil
        }
        
        let humidity: Double = coder.decodeDouble(forKey: #keyPath(humidity))
        let cloudCover: Double = coder.decodeDouble(forKey: #keyPath(cloudCover))
        let isDaylight: Bool = coder.decodeBool(forKey: #keyPath(isDaylight))
        
        self.init(
            apparentTemperature: apparentTemperature,
            dewPoint: dewPoint,
            humidity: humidity,
            temperature: temperature,
            pressure: pressure,
            pressureTrend: pressureTrend,
            wind: wind,
            cloudCover: cloudCover,
            condition: condition,
            date: date,
            isDaylight: isDaylight,
            uvIndex: uvIndex,
            visibility: visibility,
            metadata: metadata,
            symbolName: symbolName
        )
    }
    
    @nonobjc public convenience init(currentWeather: CurrentWeather) {
        self.init(
            apparentTemperature: currentWeather.apparentTemperature,
            dewPoint: currentWeather.dewPoint,
            humidity: currentWeather.humidity,
            temperature: currentWeather.temperature,
            pressure: currentWeather.pressure,
            pressureTrend: .init(pressureTrend: currentWeather.pressureTrend),
            wind: .init(wind: currentWeather.wind),
            cloudCover: currentWeather.cloudCover,
            condition: .init(weatherCondition: currentWeather.condition),
            date: currentWeather.date,
            isDaylight: currentWeather.isDaylight,
            uvIndex: .init(uvIndex: currentWeather.uvIndex),
            visibility: currentWeather.visibility,
            metadata: .init(metadata: currentWeather.metadata),
            symbolName: currentWeather.symbolName
        )
    }
    
    @nonobjc private init(
        apparentTemperature: Measurement<UnitTemperature>,
        dewPoint: Measurement<UnitTemperature>,
        humidity: Double,
        temperature: Measurement<UnitTemperature>,
        pressure: Measurement<UnitPressure>,
        pressureTrend: BPPressureTrend,
        wind: BPWind,
        cloudCover: Double,
        condition: BPWeatherCondition,
        date: Date,
        isDaylight: Bool,
        uvIndex: BPUVIndex,
        visibility: Measurement<UnitLength>,
        metadata: BPWeatherMetadata,
        symbolName: String
    ) {
        self.apparentTemperature = apparentTemperature
        self.dewPoint = dewPoint
        self.humidity = humidity
        self.temperature = temperature
        self.pressure = pressure
        self.pressureTrend = pressureTrend
        self.wind = wind
        self.cloudCover = cloudCover
        self.condition = condition
        self.date = date
        self.isDaylight = isDaylight
        self.uvIndex = uvIndex
        self.visibility = visibility
        self.metadata = metadata
        self.symbolName = symbolName
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(apparentTemperature, forKey: #keyPath(apparentTemperature))
        coder.encode(dewPoint, forKey: #keyPath(dewPoint))
        coder.encode(humidity, forKey: #keyPath(humidity))
        coder.encode(temperature, forKey: #keyPath(temperature))
        coder.encode(pressure, forKey: #keyPath(pressure))
        coder.encode(pressureTrend.rawValue, forKey: #keyPath(pressureTrend))
        coder.encode(wind, forKey: #keyPath(wind))
        coder.encode(cloudCover, forKey: #keyPath(cloudCover))
        coder.encode(condition.rawValue, forKey: #keyPath(condition))
        coder.encode(date, forKey: #keyPath(date))
        coder.encode(isDaylight, forKey: #keyPath(isDaylight))
        coder.encode(uvIndex, forKey: #keyPath(uvIndex))
        coder.encode(visibility, forKey: #keyPath(visibility))
        coder.encode(metadata, forKey: #keyPath(metadata))
        coder.encode(symbolName, forKey: #keyPath(symbolName))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPCurrentWeather(
            apparentTemperature: apparentTemperature,
            dewPoint: dewPoint,
            humidity: humidity,
            temperature: temperature,
            pressure: pressure,
            pressureTrend: pressureTrend,
            wind: wind,
            cloudCover: cloudCover,
            condition: condition,
            date: date,
            isDaylight: isDaylight,
            uvIndex: uvIndex,
            visibility: visibility,
            metadata: metadata,
            symbolName: symbolName
        )
    }
}
