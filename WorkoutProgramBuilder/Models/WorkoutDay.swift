import Foundation
import SwiftData

@Model
final class WorkoutDay {
    @Attribute(.unique) var id: UUID
    var name: String
    var order: Int
    
    @Relationship(.nullify, inverse: \WorkoutProgram.workoutDays)
    var workoutProgram: WorkoutProgram?
    
    @Relationship(.nullify, inverse: \Workout.workoutDays)
    var workouts: [Workout]
    
    init(
        id: UUID = .init(),
        name: String,
        order: Int,
        workoutProgram: WorkoutProgram? = nil
    ) {
        self.id = id
        self.name = name
        self.order = order
        self.workoutProgram = workoutProgram
    }
}
