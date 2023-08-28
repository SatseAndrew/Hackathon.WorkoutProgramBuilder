import Foundation

struct WorkoutTarget: Codable, Identifiable {
    var value: Double
    var type: WorkoutTargetType
    var id: String { type.rawValue }
    
    var formattedValue: String {
        switch type {
        case .resistance:
            String(format: "%.1f", value)
            
        case .repetition:
            String(Int(value))
            
        case .distance:
            String(format: "%.1f", value)
            
        case .duration:
            String(format: "%.1f", value)
        }
    }
    
    var formattedUnit: String {
        let isPlural = value > 1
        
        switch self.type {
        case .resistance:
            return isPlural ? "kgs" : "kg"
            
        case .repetition:
            return isPlural ? "reps" : "rep"
            
        case .distance:
            return isPlural ? "km" : "kms"
            
        case .duration:
            return "sec"
        }
    }
}

enum WorkoutTargetType: String, Codable, Identifiable, CaseIterable {
    case resistance = "Weight"
    case repetition = "Reps"
    case distance = "Distance"
    case duration = "Duration"
    
    var id: String { rawValue }
}
