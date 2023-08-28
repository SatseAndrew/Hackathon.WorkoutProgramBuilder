import Foundation

enum WorkoutCategory: String, Codable, CaseIterable {
    case cardio = "Cardio"
    case flexibility = "Flexibility"
    case endurance = "Endurance Training"
    case strength = "Strength Training"
    case rehabilitation = "Rehabilitation"
    case pregnancy = "Pregnancy"
    case seniorWorkouts = "Senior Workouts"
}
