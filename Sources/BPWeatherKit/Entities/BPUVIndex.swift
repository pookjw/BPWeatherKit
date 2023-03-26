import Foundation
import WeatherKit

@objcMembers open class BPUVIndex: NSObject, NSCoding, NSSecureCoding, NSCopying, @unchecked Sendable {
    public static let supportsSecureCoding: Bool = true
    
    @objc(BPUVIndexExposureCategory) public enum ExposureCategory: Int, Sendable {
        /// The UV index is low.
        ///
        /// The valid values of this property are 0, 1, and 2.
        case low

        /// The UV index is moderate.
        ///
        /// The valid values of this property are 3, 4, and 5.
        case moderate

        /// The UV index is high.
        ///
        /// The valid values of this property are 6 and 7.
        case high

        /// The UV index is very high.
        ///
        /// The valid values of this property are 8, 9, and 10.
        case veryHigh

        /// The UV index is extreme.
        ///
        /// The valid values of this property are 11 and higher.
        case extreme
        
        public init(exposureCategory: UVIndex.ExposureCategory) {
            switch exposureCategory {
            case .low:
                self = .low
            case .moderate:
                self = .moderate
            case .high:
                self = .high
            case .veryHigh:
                self = .veryHigh
            case .extreme:
                self = .extreme
            }
        }
        
        fileprivate var exposureCategory: UVIndex.ExposureCategory {
            switch self {
            case .low:
                return .low
            case .moderate:
                return .moderate
            case .high:
                return .high
            case .veryHigh:
                return .veryHigh
            case .extreme:
                return .extreme
            }
        }
    }
    
    public let cateogory: ExposureCategory
    public let value: Int
    
    open override var hash: Int {
        var hasher: Hasher = .init()
        
        hasher.combine(cateogory)
        hasher.combine(value)
        
        return hasher.finalize()
    }
    
    public required convenience init?(coder: NSCoder) {
        let categoryRawValue: ExposureCategory.RawValue = coder.decodeInteger(forKey: #keyPath(cateogory))
        
        guard let category: ExposureCategory = .init(rawValue: categoryRawValue) else {
            return nil
        }
        
        let value: Int = coder.decodeInteger(forKey: #keyPath(value))
        
        self.init(
            cateogory: category,
            value: value
        )
    }
    
    @nonobjc public convenience init(uvIndex: UVIndex) {
        self.init(
            cateogory: .init(exposureCategory: uvIndex.category),
            value: uvIndex.value
        )
    }
    
    @nonobjc private init(
        cateogory: ExposureCategory,
        value: Int
    ) {
        self.cateogory = cateogory
        self.value = value
        super.init()
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(cateogory.rawValue, forKey: #keyPath(cateogory))
        coder.encode(value, forKey: #keyPath(value))
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        BPUVIndex(
            cateogory: cateogory,
            value: value
        )
    }
    
    open override func isEqual(_ object: Any?) -> Bool {
        guard let other: BPUVIndex = object as? BPUVIndex else {
            return super.isEqual(object)
        }
        
        return cateogory == other.cateogory &&
        value == other.value
    }
}
