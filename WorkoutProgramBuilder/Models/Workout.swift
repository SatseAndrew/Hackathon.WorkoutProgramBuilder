import Foundation
import SwiftData

@Model
final class Workout {
    @Attribute(.unique) var id: UUID
    var name: String
    var imageName: String
    var category: String?
    var workoutDays: [WorkoutDay]
    @Relationship(.cascade) var workoutPhases: [WorkoutPhase]
    
    init(
        id: UUID = .init(),
        name: String = "Untitled",
        imageName: String = "gx-2",
        category: String? = nil,
        workoutDays: [WorkoutDay] = [],
        workoutPhases: [WorkoutPhase] = []
    ) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.category = category
        self.workoutDays = workoutDays
        self.workoutPhases = workoutPhases
    }
}
