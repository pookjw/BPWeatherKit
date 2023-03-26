import Foundation
import WeatherKit

@objcMembers open class BPForecast: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let elementType: (NSCoding & NSCopying).Type
    public let elements: [Any]
    public let metadata: BPWeatherMetadata
    
    /// A convenient localized description of the minute forecast.
    ///
    /// Available when elementType is BPMinuteWeather.
    public let summary: String?
    
    public required convenience init?(coder: NSCoder) {
        guard
            let elementTypeName: String = coder.decodeObject(forKey: #keyPath(elementType)) as? String,
            let elementType: (NSCoding & NSCopying).Type = NSClassFromString(elementTypeName) as? (NSCoding & NSCopying).Type,
            let elements: [Any] = coder.decodeObject(forKey: #keyPath(elements)) as? [Any],
            let metadata: BPWeatherMetadata = coder.decodeObject(forKey: #keyPath(metadata)) as? BPWeatherMetadata
        else {
            return nil
        }
        
        let summary: String? = coder.decodeObject(forKey: #keyPath(summary)) as? String
        
        self.init(
            elementType: elementType,
            elements: elements,
            metadata: metadata,
            summary: summary
        )
    }
    
    @nonobjc public convenience init(dailyForecast: Forecast<DayWeather>) {
        self.init(
            elementType: BPDayWeather.self,
            elements: dailyForecast.map { BPDayWeather(dayWeather: $0) },
            metadata: .init(metadata: dailyForecast.metadata),
            summary: nil
        )
    }
    
    @nonobjc public convenience init(hourlyForecast: Forecast<HourWeather>) {
        self.init(
            elementType: BPHourWeather.self,
            elements: hourlyForecast.map { BPHourWeather(hourWeather: $0) },
            metadata: .init(metadata: hourlyForecast.metadata),
            summary: nil
        )
    }
    
    @nonobjc public convenience init(minuteForecast: Forecast<MinuteWeather>) {
        self.init(
            elementType: BPMinuteWeather.self,
            elements: minuteForecast.map { BPMinuteWeather(minuteWeather: $0) },
            metadata: .init(metadata: minuteForecast.metadata),
            summary: minuteForecast.summary
        )
    }
    
    @nonobjc private init(
        elementType: (NSCoding & NSCopying).Type,
        elements: [Any],
        metadata: BPWeatherMetadata,
        summary: String?
    ) {
        self.elementType = elementType
        self.elements = elements
        self.metadata = metadata
        self.summary = summary
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(NSStringFromClass(elementType), forKey: #keyPath(elementType))
        coder.encode(elements, forKey: #keyPath(elements))
        coder.encode(metadata, forKey: #keyPath(metadata))
        coder.encode(summary, forKey: #keyPath(summary))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPForecast(
            elementType: elementType,
            elements: (elements as NSArray).copy() as! [Any],
            metadata: metadata.copy() as! BPWeatherMetadata,
            summary: summary
        )
    }
}
