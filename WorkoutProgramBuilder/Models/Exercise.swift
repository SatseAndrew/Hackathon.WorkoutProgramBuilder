import Foundation
import SwiftData

@Model
class Exercise {
    @Attribute(.unique) var id: UUID
    var name: String
    var imageName: String
    var shortDescription: String
    var guidelines: String
    var cautions: String
    var category: String?
    var compatibleTargets: [WorkoutTargetType]
    
    @Relationship(.cascade) var workoutSteps: [WorkoutStep]
    
    init(
        id: UUID = .init(),
        name: String = "Untitled",
        imageName: String = "exercise-1",
        shortDescription: String = "",
        guidelines: String = "",
        cautions: String = "",
        category: String? = nil,
        compatibleTargets: [WorkoutTargetType] = [],
        workoutSteps: [WorkoutStep] = []
    ) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.shortDescription = shortDescription
        self.guidelines = guidelines
        self.cautions = cautions
        self.category = category
        self.compatibleTargets = compatibleTargets
        self.workoutSteps = workoutSteps
    }
}
