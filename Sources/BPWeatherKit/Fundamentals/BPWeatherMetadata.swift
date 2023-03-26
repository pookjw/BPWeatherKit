import Foundation
import CoreLocation
import WeatherKit

@objcMembers open class BPWeatherMetadata: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let date: Date
    public let expirationDate: Date
    public let location: CLLocation
    
    public required convenience init?(coder: NSCoder) {
        guard
            let date: Date = coder.decodeObject(forKey: #keyPath(date)) as? Date,
            let expirationDate: Date = coder.decodeObject(forKey: #keyPath(expirationDate)) as? Date,
            let location: CLLocation = coder.decodeObject(forKey: #keyPath(location)) as? CLLocation
        else {
            return nil
        }
        
        self.init(
            date: date,
            expirationDate: expirationDate,
            location: location
        )
    }
    
    @nonobjc public convenience init(metadata: WeatherMetadata) {
        self.init(
            date: metadata.date,
            expirationDate: metadata.expirationDate,
            location: metadata.location
        )
    }
    
    @nonobjc private init(
        date: Date,
        expirationDate: Date,
        location: CLLocation
    ) {
        self.date = date
        self.expirationDate = expirationDate
        self.location = location
        super.init()
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPWeatherMetadata(
            date: date,
            expirationDate: expirationDate,
            location: location.copy() as! CLLocation
        )
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(date, forKey: #keyPath(date))
        coder.encode(expirationDate, forKey: #keyPath(expirationDate))
        coder.encode(location, forKey: #keyPath(location))
    }
}
