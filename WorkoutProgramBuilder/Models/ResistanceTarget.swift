import Foundation

//enum ResistanceTarget: Codable, Hashable, Equatable {
//    case absolute(value: Kilogram)
//    case range(from: Kilogram, to: Kilogram)
//}
//
//extension ResistanceTarget: CustomStringConvertible {
//    var description: String {
//        switch self {
//        case .absolute(let value):
//            if value == 1 {
//                return "1 kg"
//            }
//            
//            return "\(value) kgs"
//        case .range(let from, let to):
//            return "\(from) to \(to) kgs"
//        }
//    }
//}

typealias Kilogram = Float
