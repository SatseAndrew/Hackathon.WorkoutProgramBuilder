import Foundation
import SwiftData

@Model
class WorkoutStep {
    var id: UUID
    var order: Int
    var restDurationAfterCompletion: TimeInterval
    var targets: [WorkoutTarget]
    
    @Relationship(.nullify, inverse: \WorkoutRoutine.workoutSteps)
    var workoutRoutine: WorkoutRoutine?
    
    @Relationship(.nullify, inverse: \Exercise.workoutSteps)
    var exercise: Exercise?
    
    init(
        id: UUID = .init(),
        order: Int,
        restDurationAfterCompletion: TimeInterval = 45,
        targets: [WorkoutTarget] = [],
        workoutRoutine: WorkoutRoutine? = nil,
        exercise: Exercise? = nil
    ) {
        self.id = id
        self.order = order
        self.restDurationAfterCompletion = restDurationAfterCompletion
        self.targets = targets
        self.workoutRoutine = workoutRoutine
        self.exercise = exercise
    }
}
