import Foundation
import SwiftData

@Model
final class WorkoutPhase {
    @Attribute(.unique) var id: UUID
    var name: String
    var order: Int
    
    @Relationship(.nullify, inverse: \Workout.workoutPhases)
    var workout: Workout?
    
    @Relationship(.cascade)
    var workoutRoutines: [WorkoutRoutine]
    
    init(
        id: UUID = .init(),
        name: String,
        order: Int,
        workout: Workout? = nil
    ) {
        self.id = id
        self.name = name
        self.order = order
        self.workout = workout
    }
}
