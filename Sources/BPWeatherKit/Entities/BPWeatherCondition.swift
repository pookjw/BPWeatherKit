import WeatherKit

@objc public enum BPWeatherCondition: Int, Sendable {
    /// Blizzard.
    case blizzard

    /// Blowing dust or sandstorm.
    case blowingDust

    /// Blowing or drifting snow.
    case blowingSnow

    /// Breezy, light wind.
    case breezy

    /// Clear.
    case clear

    /// Cloudy, overcast conditions.
    case cloudy

    /// Drizzle or light rain.
    case drizzle

    /// Flurries or light snow.
    case flurries

    /// Fog.
    case foggy

    /// Freezing drizzle or light rain.
    case freezingDrizzle

    /// Freezing rain.
    case freezingRain

    /// Frigid conditions, low temperatures, or ice crystals.
    case frigid

    /// Hail.
    case hail

    /// Haze.
    case haze

    /// Heavy rain.
    case heavyRain

    /// Heavy snow.
    case heavySnow

    /// High temperatures.
    case hot

    /// Hurricane.
    case hurricane

    /// Thunderstorms covering less than 1/8 of the forecast area.
    case isolatedThunderstorms

    /// Mostly clear.
    case mostlyClear

    /// Mostly cloudy.
    case mostlyCloudy

    /// Partly cloudy.
    case partlyCloudy

    /// Rain.
    case rain

    /// Numerous thunderstorms spread across up to 50% of the forecast area.
    case scatteredThunderstorms

    /// Sleet.
    case sleet

    /// Smoky.
    case smoky

    /// Snow.
    case snow

    /// Notably strong thunderstorms.
    case strongStorms

    /// Snow flurries with visible sun.
    case sunFlurries

    /// Rain with visible sun.
    case sunShowers

    /// Thunderstorms.
    case thunderstorms

    /// Tropical storm.
    case tropicalStorm

    /// Windy.
    case windy

    /// Wintry mix.
    case wintryMix
    
    public init(weatherCondition: WeatherCondition) {
        switch weatherCondition {
        case .blizzard:
            self = .blizzard
        case .blowingDust:
            self = .blowingDust
        case .blowingSnow:
            self = .blizzard
        case .breezy:
            self = .breezy
        case .clear:
            self = .clear
        case .cloudy:
            self = .cloudy
        case .drizzle:
            self = .drizzle
        case .flurries:
            self = .flurries
        case .foggy:
            self = .foggy
        case .freezingDrizzle:
            self = .freezingDrizzle
        case .freezingRain:
            self = .freezingRain
        case .frigid:
            self = .frigid
        case .hail:
            self = .hail
        case .haze:
            self = .haze
        case .heavyRain:
            self = .heavyRain
        case .heavySnow:
            self = .heavySnow
        case .hot:
            self = .hot
        case .hurricane:
            self = .hurricane
        case .isolatedThunderstorms:
            self = .isolatedThunderstorms
        case .mostlyClear:
            self = .mostlyClear
        case .mostlyCloudy:
            self = .mostlyCloudy
        case .partlyCloudy:
            self = .partlyCloudy
        case .rain:
            self = .rain
        case .scatteredThunderstorms:
            self = .scatteredThunderstorms
        case .sleet:
            self = .sleet
        case .smoky:
            self = .smoky
        case .snow:
            self = .snow
        case .strongStorms:
            self = .strongStorms
        case .sunFlurries:
            self = .sunFlurries
        case .sunShowers:
            self = .sunShowers
        case .thunderstorms:
            self = .thunderstorms
        case .tropicalStorm:
            self = .tropicalStorm
        case .windy:
            self = .windy
        case .wintryMix:
            self = .wintryMix
        @unknown default:
            fatalError()
        }
    }
    
    fileprivate var weatherCondition: WeatherCondition {
        switch self {
        case .blizzard:
            return .blizzard
        case .blowingDust:
            return .blowingDust
        case .blowingSnow:
            return .blizzard
        case .breezy:
            return .breezy
        case .clear:
            return .clear
        case .cloudy:
            return .cloudy
        case .drizzle:
            return .drizzle
        case .flurries:
            return .flurries
        case .foggy:
            return .foggy
        case .freezingDrizzle:
            return .freezingDrizzle
        case .freezingRain:
            return .freezingRain
        case .frigid:
            return .frigid
        case .hail:
            return .hail
        case .haze:
            return .haze
        case .heavyRain:
            return .heavyRain
        case .heavySnow:
            return .heavySnow
        case .hot:
            return .hot
        case .hurricane:
            return .hurricane
        case .isolatedThunderstorms:
            return .isolatedThunderstorms
        case .mostlyClear:
            return .mostlyClear
        case .mostlyCloudy:
            return .mostlyCloudy
        case .partlyCloudy:
            return .partlyCloudy
        case .rain:
            return .rain
        case .scatteredThunderstorms:
            return .scatteredThunderstorms
        case .sleet:
            return .sleet
        case .smoky:
            return .smoky
        case .snow:
            return .snow
        case .strongStorms:
            return .strongStorms
        case .sunFlurries:
            return .sunFlurries
        case .sunShowers:
            return .sunShowers
        case .thunderstorms:
            return .thunderstorms
        case .tropicalStorm:
            return .tropicalStorm
        case .windy:
            return .windy
        case .wintryMix:
            return .wintryMix
        }
    }
}

@_cdecl("BPWeatherCondition_accessibilityDescription") public func BPWeatherCondition_accessibilityDescription(rawValue: Int) -> String? {
    BPWeatherCondition(rawValue: rawValue)?.weatherCondition.accessibilityDescription
}

@_cdecl("BPWeatherCondition_description") public func BPWeatherCondition_description(rawValue: Int) -> String? {
    BPWeatherCondition(rawValue: rawValue)?.weatherCondition.description
}
