import Foundation

//enum DurationTarget: Codable, Hashable, Equatable {
//    case absolute(value: Second)
//    case range(from: Second, to: Second)
//    case toFailure
//}
//
//extension DurationTarget: CustomStringConvertible {
//    var description: String {
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.hour, .minute, .second]
//        
//        switch self {
//        case .absolute(let value):
//            return formatter.string(from: TimeInterval(value)) ?? "unknown"
//        case .range(let from, let to):
//            let formattedFrom = formatter.string(from: TimeInterval(from)) ?? "unknown"
//            let formattedTo = formatter.string(from: TimeInterval(to)) ?? "unknown"
//            return "\(formattedFrom) to \(formattedTo)"
//        case .toFailure:
//            return "To Failure"
//        }
//    }
//}

typealias Second = TimeInterval
