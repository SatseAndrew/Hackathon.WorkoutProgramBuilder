import Foundation

//enum DistanceTarget: Codable, Hashable, Equatable {
//    case absolute(value: Kilometer)
//    case range(from: Kilometer, to: Kilometer)
//    case toFailure
//}
//
//extension DistanceTarget: CustomStringConvertible {
//    var description: String {
//        switch self {
//        case .absolute(let value):
//            if value == 1 {
//                return "1 km"
//            }
//            
//            return "\(value) kms"
//        case .range(let from, let to):
//            return "\(from) to \(to)"
//        case .toFailure:
//            return "To Failure"
//        }
//    }
//}

typealias Kilometer = Float
