import Foundation

//enum RepetitionTarget: Codable, Hashable, Equatable {
//    case absolute(value: Repetition)
//    case range(from: Repetition, to: Repetition)
//    case toFailure
//}
//
//extension RepetitionTarget: CustomStringConvertible {
//    var description: String {
//        switch self {
//        case .absolute(let value):
//            if value == 1 {
//                return "1 Rep"
//            }
//            
//            return "\(value) Reps"
//        case .range(let from, let to):
//            return "\(from) to \(to) reps"
//        case .toFailure:
//            return "To Failure"
//        }
//    }
//}

typealias Repetition = Int
