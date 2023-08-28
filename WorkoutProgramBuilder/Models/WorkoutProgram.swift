import Foundation
import SwiftData

@Model
final class WorkoutProgram {
    @Attribute(.unique) var id: UUID
    var name: String
    var order: Int
    var imageName: String
    var category: String?
    var workoutDays: [WorkoutDay]
    
    init(
        id: UUID = .init(),
        name: String = "Untitled",
        order: Int,
        imageName: String = "gx-4",
        category: String? = nil,
        workoutDays: [WorkoutDay] = []
    ) {
        self.id = id
        self.name = name
        self.order = order
        self.imageName = imageName
        self.category = category
        self.workoutDays = workoutDays
    }
}
