import SwiftUI
import SwiftData

@main
struct WorkoutProgramBuilderApp: App {

    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.dark)
                .modelContainer(
                    for: [
                        WorkoutProgram.self,
                        WorkoutDay.self,
                        Workout.self,
                        WorkoutPhase.self,
                        WorkoutRoutine.self,
                        WorkoutStep.self,
                        Exercise.self
                    ]
                )
        }
    }
}

extension View {
    func addContainer() -> some View {
        modelContainer(
            for: [
                WorkoutProgram.self,
                WorkoutDay.self,
                Workout.self,
                WorkoutPhase.self,
                WorkoutRoutine.self,
                WorkoutStep.self,
                Exercise.self
            ]
        )
    }
}
