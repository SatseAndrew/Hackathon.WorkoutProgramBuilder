import SwiftUI

struct WorkoutProgramView: View {
    @Binding var path: NavigationPath
    @Bindable var workoutProgram: WorkoutProgram
    @Environment(\.modelContext) private var context
    @Environment(\.editMode) private var editMode
    @State private var selectWorkoutsForDay: WorkoutDay?
    @State private var isSelectingImage = false
    
    var sortedWorkoutDays: [WorkoutDay] {
        workoutProgram.workoutDays.sorted(by: { $0.order < $1.order })
    }
    
    var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var body: some View {
        Form {
            Section {
                VStack {
                    TextField("Workout Program Name", text: $workoutProgram.name)
                    
                    Picker("Category:", selection: $workoutProgram.category) {
                        ForEach(WorkoutCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category.rawValue as String?)
                        }
                        
                        Text("None")
                            .tag(nil as String?)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    HStack {
                        Image(workoutProgram.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80 * 0.75)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 8)
                            )
                        
                        Spacer()
                        
                        Button(action: { isSelectingImage = true }, label: {
                            Text("Select")
                        })
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .padding(.top, 12)
                    
                }
            } header: { Text("Info") }
            
            Section {
                if workoutProgram.workoutDays.isEmpty {
                    Text("Add workout days to your timeline.")
                        .italic()
                        .padding()
                } else {
                    ForEach(sortedWorkoutDays) { workoutDay in
                        workoutDayRow(for: workoutDay)
                    }
                    .onDelete(perform: deleteWorkoutDays)
                    .onMove(perform: moveWorkoutDays)
                }
            } header: {
                HStack {
                    Text("Timeline")
                    
                    Spacer()
                    
                    if isEditing {
                        Button(action: addWorkoutDay, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
            }
        }
        .toolbar {
            EditButton()
        }
        .sheet(item: $selectWorkoutsForDay, content: {
            WorkoutSelectorView(selection: binding(for: $0).workouts)
        })
        .sheet(isPresented: $isSelectingImage, content: {
            ImageSelectorView(selection: $workoutProgram.imageName)
        })
        .navigationDestination(for: Workout.self, destination: {
            WorkoutView(workout: $0)
        })
    }
    
    private func workoutDayRow(for workoutDay: WorkoutDay) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 16) {
                Text(workoutDay.name)
             
                if workoutDay.workouts.isEmpty {
                    Text("Rest day")
                        .font(.footnote)
                        .foregroundStyle(Color.secondary)
                }
            }
            
            if !workoutDay.workouts.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(workoutDay.workouts) { workout in
                        Button(action: { path.append(workout) }, label: {
                            HStack(spacing: 10) {
                                WorkoutImage(name: workout.imageName, size: .small)
                                
                                Text(workout.name)
                                    .font(.footnote)
                            }
                        })
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 4)
                .padding(.leading, 16)
            }
            
            if isEditing {
                Button(action: { selectWorkoutsForDay = workoutDay }, label: {
                    Text("Select workouts")
                        .font(.footnote)
                })
                .buttonStyle(BorderlessButtonStyle())
            }
        }
//        .padding(.bottom, 4)
        .navigationTitle("Program Details")
    }
    
    private func addWorkoutDay() {
        let workoutDay = WorkoutDay(
            name: "Day \(workoutProgram.workoutDays.count)",
            order: workoutProgram.workoutDays.count,
            workoutProgram: workoutProgram
        )
        
        workoutProgram.workoutDays.append(workoutDay)
    }
    
    private func deleteWorkoutDays(from source: IndexSet) {
        for index in source {
            workoutProgram.workoutDays.remove(at: index)
        }
    }
    
    private func moveWorkoutDays(from source: IndexSet, to destination: Int) {
        var copy = sortedWorkoutDays
        copy.move(fromOffsets: source, toOffset: destination)
        
        for (index, workoutDay) in copy.enumerated() {
            workoutDay.order = index
        }
    }
    
    private func binding(for workoutDay: WorkoutDay) -> Binding<WorkoutDay> {
        $workoutProgram.workoutDays.binding(for: workoutDay)
    }
}
