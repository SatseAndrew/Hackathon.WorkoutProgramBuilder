import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            WorkoutProgramList()
                .tabItem {
                    Label("Workout Programs", systemImage: "text.book.closed")
                }
            
            WorkoutList()
                .tabItem {
                    Label("Workouts", systemImage: "figure.run.square.stack")
                }
            
            ExerciseList()
                .tabItem {
                    Label("Exercises", systemImage: "dumbbell")
                }
        }
    }
}

#Preview {
    MainView()
}
