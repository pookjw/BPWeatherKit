import Foundation
import WeatherKit

@objcMembers open class BPWeatherAttribution: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let combinedMarkDarkURL: URL
    public let combinedMarkLightURL: URL
    public let legalPageURL: URL
    public let serviceName: String
    public let squareMarkURL: URL
    
    @available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *)
    public var legalAttributionText: String {
        backedLegalAttributionText ?? .init()
    }
    @objc private var backedLegalAttributionText: String?
    
    open override var hash: Int {
        var hasher: Hasher = .init()
        
        hasher.combine(combinedMarkDarkURL)
        hasher.combine(combinedMarkLightURL)
        hasher.combine(legalPageURL)
        hasher.combine(serviceName)
        hasher.combine(squareMarkURL)
        hasher.combine(backedLegalAttributionText)
        
        return hasher.finalize()
    }
    
    public required convenience init?(coder: NSCoder) {
        guard
            let combinedMarkDarkURL: URL = coder.decodeObject(forKey: #keyPath(combinedMarkDarkURL)) as? URL,
            let combinedMarkLightURL: URL = coder.decodeObject(forKey: #keyPath(combinedMarkLightURL)) as? URL,
            let legalPageURL: URL = coder.decodeObject(forKey: #keyPath(legalPageURL)) as? URL,
            let serviceName: String = coder.decodeObject(forKey: #keyPath(serviceName)) as? String,
            let squareMarkURL: URL = coder.decodeObject(forKey: #keyPath(squareMarkURL)) as? URL
        else {
            return nil
        }
        
        let backedLegalAttributionText: String? = coder.decodeObject(forKey: #keyPath(backedLegalAttributionText)) as? String
        
        self.init(
            combinedMarkDarkURL: combinedMarkDarkURL,
            combinedMarkLightURL: combinedMarkLightURL,
            legalPageURL: legalPageURL,
            serviceName: serviceName,
            squareMarkURL: squareMarkURL,
            backedLegalAttributionText: backedLegalAttributionText
        )
    }
    
    @nonobjc public convenience init(weatherAttribution: WeatherAttribution) {
        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
            self.init(
                combinedMarkDarkURL: weatherAttribution.combinedMarkDarkURL,
                combinedMarkLightURL: weatherAttribution.combinedMarkLightURL,
                legalPageURL: weatherAttribution.legalPageURL,
                serviceName: weatherAttribution.serviceName,
                squareMarkURL: weatherAttribution.squareMarkURL,
                backedLegalAttributionText: weatherAttribution.legalAttributionText
            )
        } else {
            self.init(
                combinedMarkDarkURL: weatherAttribution.combinedMarkDarkURL,
                combinedMarkLightURL: weatherAttribution.combinedMarkLightURL,
                legalPageURL: weatherAttribution.legalPageURL,
                serviceName: weatherAttribution.serviceName,
                squareMarkURL: weatherAttribution.squareMarkURL,
                backedLegalAttributionText: nil
            )
        }
    }
    
    @nonobjc private init(
        combinedMarkDarkURL: URL,
        combinedMarkLightURL: URL,
        legalPageURL: URL,
        serviceName: String,
        squareMarkURL: URL,
        backedLegalAttributionText: String?
    ) {
        self.combinedMarkDarkURL = combinedMarkDarkURL
        self.combinedMarkLightURL = combinedMarkLightURL
        self.legalPageURL = legalPageURL
        self.serviceName = serviceName
        self.squareMarkURL = squareMarkURL
        self.backedLegalAttributionText = backedLegalAttributionText
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(combinedMarkDarkURL, forKey: #keyPath(combinedMarkDarkURL))
        coder.encode(combinedMarkLightURL, forKey: #keyPath(combinedMarkLightURL))
        coder.encode(legalPageURL, forKey: #keyPath(legalPageURL))
        coder.encode(serviceName, forKey: #keyPath(serviceName))
        coder.encode(squareMarkURL, forKey: #keyPath(squareMarkURL))
        coder.encode(backedLegalAttributionText, forKey: #keyPath(backedLegalAttributionText))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPWeatherAttribution(
            combinedMarkDarkURL: combinedMarkDarkURL,
            combinedMarkLightURL: combinedMarkLightURL,
            legalPageURL: legalPageURL,
            serviceName: serviceName,
            squareMarkURL: squareMarkURL,
            backedLegalAttributionText: backedLegalAttributionText
        )
    }
}
