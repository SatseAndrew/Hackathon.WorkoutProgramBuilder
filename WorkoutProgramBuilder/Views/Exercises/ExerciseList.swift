import SwiftUI
import SwiftData

struct ExerciseList: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Exercise.category) var items: [Exercise]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Add exercises, complete with detailed descriptions on how to perform them correctly, and provide cautionary guidance on how to reduce the risk of injury.")
                    .foregroundStyle(Color.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                List {
                    ForEach(items) { item in
                        NavigationLink(value: item, label: {
                            HStack(spacing: 16) {
                                Image(item.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 50)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 8)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                    
                                    Text(item.category ?? "No category")
                                        .font(.footnote)
                                        .foregroundStyle(Color.secondary)
                                }
                            }
                        })
                    }
                    .onDelete(perform: delete)
                }
                .toolbar {
                    ToolbarItem {
                        Button(action: add, label: {
                            Label("Add Exercise", systemImage: "plus")
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
                .navigationTitle("Exercises")
                .navigationDestination(for: Exercise.self, destination: { exercise in
                    ExerciseView(exercise: exercise)
                })
            }
        }
    }
    
    private func add() {
        context.insert(Exercise())
    }
    
    private func delete(from source: IndexSet) {
        for index in source {
            let item = items[index]
            context.delete(item)
        }
    }
}

