import Foundation
import WeatherKit

@objcMembers open class BPWeatherAlert: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public let metadata: BPWeatherMetadata
    public let region: String?
    
    
    public required init?(coder: NSCoder) {
        <#code#>
    }
    
    public func encode(with coder: NSCoder) {
        <#code#>
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        <#code#>
    }
    
    public static let supportsSecureCoding: Bool = true
    
}
