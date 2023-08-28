import Foundation
import SwiftData

@Model
final class WorkoutRoutine {
    var id: UUID
    var name: String
    var order: Int
    var restDurationAfterCompletion: TimeInterval
    
    @Relationship(.nullify, inverse: \WorkoutPhase.workoutRoutines)
    var workoutPhase: WorkoutPhase?
    
    @Relationship(.cascade)
    var workoutSteps: [WorkoutStep]
    
    init(
        id: UUID = .init(),
        name: String,
        order: Int,
        restDurationAfterCompletion: TimeInterval = 120,
        workoutPhase: WorkoutPhase? = nil,
        workoutSteps: [WorkoutStep] = []
    ) {
        self.id = id
        self.name = name
        self.order = order
        self.restDurationAfterCompletion = restDurationAfterCompletion
        self.workoutPhase = workoutPhase
        self.workoutSteps = workoutSteps
    }
}
