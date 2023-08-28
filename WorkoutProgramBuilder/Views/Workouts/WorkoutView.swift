import SwiftUI
import SwiftData

struct WorkoutView: View {
    @Bindable var workout: Workout
    @Environment(\.editMode) private var editMode
    @Environment(\.modelContext) private var context
    @State private var isSelectingImage = false
    
    var sortedWorkoutPhases: [WorkoutPhase] {
        workout.workoutPhases.sorted(by: { $0.order < $1.order })
    }
    
    var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var body: some View {
        Form {
            Section {
                VStack {
                    TextField("Workout Name", text: $workout.name)
                    
                    Picker("Category:", selection: $workout.category) {
                        ForEach(WorkoutCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category.rawValue as String?)
                        }
                        
                        Text("None")
                            .tag(nil as String?)
                    }
                }
            } header: { Text("Info") }
            
            Section {
                HStack {
                    Image(workout.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 50)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                    
                    Spacer()
                    
                    Button(action: { isSelectingImage = true }, label: {
                        Text("Select")
                    })
                }
            } header: { Text("Exercise Image") }
            
            Section {
                if sortedWorkoutPhases.isEmpty {
                    Text("Add phases to your workout")
                        .italic()
                        .padding()
                } else {
                    ForEach(sortedWorkoutPhases) { workoutPhase in
                        NavigationLink(value: workoutPhase, label: {
                            HStack {
                                TextField("Phase Name", text: $workout.workoutPhases.binding(for: workoutPhase).name)
                                    .frame(maxWidth: 100)
                                Spacer()
                            }
                        })
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            } header: {
                HStack {
                    Text("Workout Phases:")
                    
                    Spacer()
                    
                    if isEditing {
                        menu
                    }
                    
                }
                .id(UUID())
            }
        }
        .toolbar {
            EditButton()
        }
        .navigationTitle("Workout Details")
        .navigationDestination(for: WorkoutPhase.self, destination: {
            WorkoutPhaseView(workoutPhase: $0)
        })
        .sheet(isPresented: $isSelectingImage, content: {
            ImageSelectorView(selection: $workout.imageName)
        })
    }
    
    private var menu: some View {
        Menu {
            Button("Warm Up", action: {
                append(
                    workoutPhase: .init(
                        name: "Warm Up",
                        order: workout.workoutPhases.count,
                        workout: workout
                    )
                )
            })
            
            Button("Training", action: {
                append(
                    workoutPhase: .init(
                        name: "Training",
                        order: workout.workoutPhases.count,
                        workout: workout
                    )
                )
            })
            
            Button("Cool Down", action: {
                append(
                    workoutPhase: .init(
                        name: "Cool Down",
                        order: workout.workoutPhases.count,
                        workout: workout
                    )
                )
            })
            
            Button("Custom", action: {
                append(
                    workoutPhase: .init(
                        name: "Custom",
                        order: workout.workoutPhases.count,
                        workout: workout
                    )
                )
            })
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private func append(workoutPhase: WorkoutPhase) {
        workout.workoutPhases.append(workoutPhase)
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        var copy = sortedWorkoutPhases
        copy.move(fromOffsets: source, toOffset: destination)
        
        for (index, workoutPhase) in copy.enumerated() {
            workoutPhase.order = index
        }
    }
    
    private func delete(from source: IndexSet) {
        for index in source {
            workout.workoutPhases.remove(at: index)
        }
    }
}

#Preview {
    WorkoutView(workout: .init())
}
