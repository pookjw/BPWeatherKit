import Foundation
import WeatherKit

@objcMembers open class BPMoonEvents: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    public let moonrise: Date?
    public let moonset: Date?
    public let phase: BPMoonPhase
    
    open override var hash: Int {
        var hasher: Hasher = .init()
        
        hasher.combine(moonrise)
        hasher.combine(moonset)
        hasher.combine(phase)
        
        return hasher.finalize()
    }
    
    public required convenience init?(coder: NSCoder) {
        let phaseRawValue: BPMoonPhase.RawValue = coder.decodeInteger(forKey: #keyPath(phase))
        
        guard let phase: BPMoonPhase = .init(rawValue: phaseRawValue) else {
            return nil
        }
        
        let moonrise: Date? = coder.decodeObject(forKey: #keyPath(moonrise)) as? Date
        let moonset: Date? = coder.decodeObject(forKey: #keyPath(moonset)) as? Date
        
        self.init(
            moonrise: moonrise,
            moonset: moonset,
            phase: phase
        )
    }
    
    @nonobjc public convenience init(moonEvents: MoonEvents) {
        self.init(
            moonrise: moonEvents.moonrise,
            moonset: moonEvents.moonset,
            phase: .init(moonPhase: moonEvents.phase)
        )
    }
    
    @nonobjc private init(
        moonrise: Date?,
        moonset: Date?,
        phase: BPMoonPhase
    ) {
        self.moonrise = moonrise
        self.moonset = moonset
        self.phase = phase
        
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(moonrise, forKey: #keyPath(moonrise))
        coder.encode(moonset, forKey: #keyPath(moonset))
        coder.encode(phase.rawValue, forKey: #keyPath(phase))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPMoonEvents(
            moonrise: moonrise,
            moonset: moonset,
            phase: phase
        )
    }
}
