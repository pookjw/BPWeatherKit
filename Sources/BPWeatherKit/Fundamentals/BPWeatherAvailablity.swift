import Foundation
import WeatherKit

@objcMembers open class BPWeatherAvailablity: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    @objc(BPWeatherAvailablityKind) public enum AvailabilityKind: Int, Sendable {
        /// The data is available.
        case available

        /// The data is supported for the location but is temporarily unavailable.
        case temporarilyUnavailable

        /// The data isn't supported for the location.
        case unsupported

        /// The availability is unknown.
        case unknown
        
        public init(availabilityKind: WeatherAvailability.AvailabilityKind) {
            switch availabilityKind {
            case .available:
                self = .available
            case .temporarilyUnavailable:
                self = .temporarilyUnavailable
            case .unsupported:
                self = .unsupported
            case .unknown:
                self = .unknown
            @unknown default:
                fatalError()
            }
        }
        
        fileprivate var availabilityKind: WeatherAvailability.AvailabilityKind {
            switch self {
            case .available:
                return .available
            case .temporarilyUnavailable:
                return .temporarilyUnavailable
            case .unsupported:
                return .unsupported
            case .unknown:
                return .unknown
            }
        }
    }
    
    public let alertAvailability: AvailabilityKind
    public let minuteAvailability: AvailabilityKind
    
    public required init?(coder: NSCoder) {
        let alertAvailabilityRawValue: Int = coder.decodeInteger(forKey: #keyPath(alertAvailability))
        let minuteAvailabilityRawValue: Int = coder.decodeInteger(forKey: #keyPath(minuteAvailability))
        
        guard
            let alertAvailability: AvailabilityKind = .init(rawValue: alertAvailabilityRawValue),
            let minuteAvailability: AvailabilityKind = .init(rawValue: minuteAvailabilityRawValue)
        else {
            return nil
        }
        
        self.alertAvailability = alertAvailability
        self.minuteAvailability = minuteAvailability
        
        super.init()
    }
    
    @nonobjc public convenience init(weatherAvailablity: WeatherAvailability) {
        self.init(
            alertAvailability: .init(availabilityKind: weatherAvailablity.alertAvailability),
            minuteAvailability: .init(availabilityKind: weatherAvailablity.minuteAvailability)
        )
    }
    
    @nonobjc private init(
        alertAvailability: AvailabilityKind,
        minuteAvailability: AvailabilityKind
    ) {
        self.alertAvailability = alertAvailability
        self.minuteAvailability = minuteAvailability
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(alertAvailability.rawValue, forKey: #keyPath(alertAvailability))
        coder.encode(minuteAvailability.rawValue, forKey: #keyPath(minuteAvailability))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPWeatherAvailablity(
            alertAvailability: alertAvailability,
            minuteAvailability: minuteAvailability
        )
    }
}