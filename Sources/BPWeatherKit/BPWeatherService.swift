import Foundation
import CoreLocation
import WeatherKit

@objcMembers open class BPWeatherService: NSObject, @unchecked Sendable {
    /// A single, shared weather service object.
    ///
    /// Use this object to interface to weather services in your application. If you need to prioritize weather information,
    /// create separate instances with `init`.
    @objc(sharedInstance) public static let shared: BPWeatherService = .init(weatherService: .shared)
    
    private let weatherService: WeatherService
    
    public convenience override init() {
        self.init(weatherService: .init())
    }
    
    @nonobjc private init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    @objc(weatherForLocation:completionHandler:)
    open func weather(for location: CLLocation) async throws -> BPWeather {
        let weather: Weather = try await weatherService.weather(for: location)
        return .init(weather: weather)
    }
    
    @objc(weatherForLocation:includingQueries:completionHandler:)
    open func weather(for location: CLLocation, including queries: [BPWeatherQuery]) async throws -> [Any] {
        return try await withThrowingTaskGroup(of: (Int, Any).self, returning: [Int: Any].self) { [weatherService] group in
            queries
                .enumerated()
                .forEach { index, query in
                    group.addTask {
                        let result: Any
                        
                        switch query.weatherQuery {
                        case .current:
                            result = try await weatherService.weather(for: location, including: .current) as Any
                        case .minute:
                            result = try await weatherService.weather(for: location, including: .minute) as Any
                        case .hourly:
                            result = try await weatherService.weather(for: location, including: .hourly) as Any
                        case .daily:
                            result = try await weatherService.weather(for: location, including: .daily) as Any
                        case .alerts:
                            result = try await weatherService.weather(for: location, including: .alerts) as Any
                        case .availability:
                            result = try await weatherService.weather(for: location, including: .availability) as Any
                        case ._daily(let startDate, let endDate):
                            result = try await weatherService.weather(for: location, including: .daily(startDate: startDate!, endDate: endDate!)) as Any
                        case ._hourly(let startDate, let endDate):
                            result = try await weatherService.weather(for: location, including: .hourly(startDate: startDate!, endDate: endDate!)) as Any
                        }
                        
                        return (index, result)
                    }
                }
            
            return try await group
                .reduce(.init()) { partialResult, next in
                    var result: [Int: Any] = partialResult
                    result[next.0] = next.1
                    return result
                }
        }
        .sorted(by: { $0.key < $1.key })
        .map { $0.value }
    }
}

/*
 var tryCount: Int = queries.count
 var iteration: Int = .zero
 
 while tryCount > .zero {
     let baseIndex: Int = iteration * 6
     
     let parametersCount: Int
     if tryCount % 6 == .zero {
         parametersCount = 6
     } else {
         parametersCount = tryCount % 6
     }
     
     switch parametersCount {
     case 1:
         group.addTask {
             try await [
                 baseIndex: weatherService
                     .weather(
                         for: location,
                         including: queries[baseIndex]._weatherQuery()
                     )
             ]
         }
     case 2:
         group.addTask {
             let results: (Any, Any) = try await weatherService
                 .weather(
                     for: location,
                     including: queries[baseIndex]._weatherQuery(),
                     queries[baseIndex + 1]._weatherQuery()
                 )
             
             return try await [
                 baseIndex: results.0,
                 baseIndex + 1: results.1
             ]
         }
     case 3:
         group.addTask {
             let results: (Any, Any, Any) = try await weatherService
                 .weather(
                     for: location,
                     including: queries[baseIndex]._weatherQuery() as! CurrentWeather,
                     queries[baseIndex + 1]._weatherQuery(),
                     queries[baseIndex + 2]._weatherQuery()
                 )
             
             return try await [
                 baseIndex: results.0,
                 baseIndex + 1: results.1,
                 baseIndex + 2: results.2
             ]
         }
     case 4:
         group.addTask {
             let results: (Any, Any, Any, Any) = try await weatherService
                 .weather(
                     for: location,
                     including: queries[baseIndex]._weatherQuery(),
                     queries[baseIndex + 1]._weatherQuery(),
                     queries[baseIndex + 2]._weatherQuery(),
                     queries[baseIndex + 3]._weatherQuery()
                 )
             
             return try await [
                 baseIndex: results.0,
                 baseIndex + 1: results.1,
                 baseIndex + 2: results.2,
                 baseIndex + 3: results.3
             ]
         }
     case 5:
         group.addTask {
             let results: (Any, Any, Any, Any, Any) = try await weatherService
                 .weather(
                     for: location,
                     including: queries[baseIndex]._weatherQuery(),
                     queries[baseIndex + 1]._weatherQuery(),
                     queries[baseIndex + 2]._weatherQuery(),
                     queries[baseIndex + 3]._weatherQuery(),
                     queries[baseIndex + 4]._weatherQuery()
                 )
             
             return try await [
                 baseIndex: results.0,
                 baseIndex + 1: results.1,
                 baseIndex + 2: results.2,
                 baseIndex + 3: results.3,
                 baseIndex + 4: results.4
             ]
         }
     case 6:
         group.addTask {
             let results: (Any, Any, Any, Any, Any, Any) = try await weatherService
                 .weather(
                     for: location,
                     including: queries[baseIndex]._weatherQuery(),
                     queries[baseIndex + 1]._weatherQuery(),
                     queries[baseIndex + 2]._weatherQuery(),
                     queries[baseIndex + 3]._weatherQuery(),
                     queries[baseIndex + 4]._weatherQuery(),
                     queries[baseIndex + 5]._weatherQuery()
                 )
             
             return try await [
                 baseIndex: results.0,
                 baseIndex + 1: results.1,
                 baseIndex + 2: results.2,
                 baseIndex + 3: results.3,
                 baseIndex + 4: results.4,
                 baseIndex + 5: results.5
             ]
         }
     default:
         break
     }
     
     tryCount -= parametersCount
     iteration += 1
 }
 
 return try await group.reduce([:]) { partialResult, next in
     return partialResult.merging(next, uniquingKeysWith: { i, _ in i })
 }
 */
