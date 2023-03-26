import Foundation
import WeatherKit

@objcMembers open class BPWeatherAlert: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let metadata: BPWeatherMetadata
    public let region: String?
    public let severity: BPWeatherSeverity
    public let summary: String
    public let detailsURL: URL
    public let source: String
    
    open override var hash: Int {
        var hasher: Hasher = .init()
        
        hasher.combine(metadata)
        hasher.combine(region)
        hasher.combine(severity)
        hasher.combine(summary)
        hasher.combine(detailsURL)
        hasher.combine(source)
        
        return hasher.finalize()
    }
    
    public required convenience init?(coder: NSCoder) {
        let severityRawValue: BPWeatherSeverity.RawValue = coder.decodeInteger(forKey: #keyPath(severity))
        
        guard
            let metadata: BPWeatherMetadata = coder.decodeObject(forKey: #keyPath(metadata)) as? BPWeatherMetadata,
            let severity: BPWeatherSeverity = .init(rawValue: severityRawValue),
            let summary: String = coder.decodeObject(forKey: #keyPath(summary)) as? String,
            let detailsURL: URL = coder.decodeObject(forKey: #keyPath(detailsURL)) as? URL,
            let source: String = coder.decodeObject(forKey: #keyPath(source)) as? String
        else {
            return nil
        }
        
        let region: String? = coder.decodeObject(forKey: #keyPath(region)) as? String
        
        self.init(
            metadata: metadata,
            region: region,
            severity: severity,
            summary: summary,
            detailsURL: detailsURL,
            source: source
        )
    }
    
    @nonobjc public convenience init(weatherAlert: WeatherAlert) {
        self.init(
            metadata: .init(metadata: weatherAlert.metadata),
            region: weatherAlert.region,
            severity: .init(weatherSeverity: weatherAlert.severity),
            summary: weatherAlert.summary,
            detailsURL: weatherAlert.detailsURL,
            source: weatherAlert.source
        )
    }
    
    @nonobjc private init(
        metadata: BPWeatherMetadata,
        region: String?,
        severity: BPWeatherSeverity,
        summary: String,
        detailsURL: URL,
        source: String
    ) {
        self.metadata = metadata
        self.region = region
        self.severity = severity
        self.summary = summary
        self.detailsURL = detailsURL
        self.source = source
        
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(metadata, forKey: #keyPath(metadata))
        coder.encode(region, forKey: #keyPath(region))
        coder.encode(severity.rawValue, forKey: #keyPath(severity))
        coder.encode(summary, forKey: #keyPath(summary))
        coder.encode(detailsURL, forKey: #keyPath(detailsURL))
        coder.encode(source, forKey: #keyPath(source))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPWeatherAlert(
            metadata: metadata.copy() as! BPWeatherMetadata,
            region: region,
            severity: severity,
            summary: summary,
            detailsURL: detailsURL,
            source: source
        )
    }
    
    open override func isEqual(_ object: Any?) -> Bool {
        guard let other: BPWeatherAlert = object as? BPWeatherAlert else {
            return super.isEqual(object)
        }
        
        return metadata == other.metadata &&
        region == other.region &&
        severity == other.severity &&
        summary == other.summary &&
        detailsURL == other.detailsURL &&
        source == other.source
    }
}
