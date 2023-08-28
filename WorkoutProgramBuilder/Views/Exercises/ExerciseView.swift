import SwiftUI

struct ExerciseView: View {
    @Bindable var exercise: Exercise
    @Environment(\.editMode) private var editMode
    @Environment(\.modelContext) private var context
    @State private var isSelectingImage = false
    
    var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    func workoutTargetSelectionBinding(
        from selected: [WorkoutTargetType]
    ) -> Binding<Set<WorkoutTargetType>> {
        Binding<Set<WorkoutTargetType>>(
            get: {
                Set(selected)
            },
            set: { newValue in
                exercise.compatibleTargets = Array(newValue)
            }
        )
    }
    
    var body: some View {
        List {
            Section {
                VStack {
                    TextField("Exercise Name", text: $exercise.name)
                    
                    Picker("Category:", selection: $exercise.category) {
                        ForEach(WorkoutCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category.rawValue as String?)
                        }
                        
                        Text("None")
                            .tag(nil as String?)
                    }
                    .frame(height: 50)
                }
            } header: { Text("Basic Info") }
            
            Section {
                HStack {
                    Image(exercise.imageName)
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
                MultiSelector(
                    options: WorkoutTargetType.allCases,
                    optionToString: { $0.rawValue },
                    selected: workoutTargetSelectionBinding(from: exercise.compatibleTargets)
                ) {
                    Text("Targets")
                }
            } header: { Text("Compatible Workout Targets") }
            
            Section {
                TextEditor(text: $exercise.shortDescription)
                    .frame(height: 100)
            } header: { Text("Short Description") }
            
            Section {
                TextEditor(text: $exercise.guidelines)
                    .frame(height: 100)
            } header: { Text("Guidance") }
            
            Section {
                TextEditor(text: $exercise.cautions)
                    .frame(height: 100)
            } header: { Text("Caution") }
        }
        .navigationTitle("Exercise Details")
        .sheet(isPresented: $isSelectingImage, content: {
            ImageSelectorView(selection: $exercise.imageName)
        })
    }
}
