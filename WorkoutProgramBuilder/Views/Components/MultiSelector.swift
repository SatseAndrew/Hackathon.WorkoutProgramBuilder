import SwiftUI

struct MultiSelector<LabelView: View, Selectable: Identifiable & Hashable>: View {
    let label: () -> LabelView
    let options: [Selectable]
    let optionToString: (Selectable) -> String
    var selected: Binding<Set<Selectable>>
    
    init(
        options: [Selectable],
        optionToString: @escaping (Selectable) -> String,
        selected: Binding<Set<Selectable>>,
        @ViewBuilder label: @escaping () -> LabelView
    ) {
        self.options = options
        self.optionToString = optionToString
        self.selected = selected
        self.label = label
    }

    var body: some View {
        NavigationLink(destination: MultiSelectionView(options: options, optionToString: optionToString, selected: selected)) {
            HStack {
                label()
                Spacer()
                Text(selectionText)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(Color.secondary)
            }
        }
    }
    
    private var selectionText: String {
        let selectionCount = selected.wrappedValue.count
        
        if selectionCount == 0 {
            return "None Selected"
        } else if selectionCount == 1 {
            return "1 Selected"
        } else {
            return "\(selectionCount) Selected"
        }
    }
}

struct MultiSelectionView<Selectable: Identifiable & Hashable>: View {
    let options: [Selectable]
    let optionToString: (Selectable) -> String

    @Binding
    var selected: Set<Selectable>
    
    var body: some View {
        List {
            ForEach(options) { selectable in
                Button(action: { toggleSelection(selectable: selectable) }) {
                    HStack {
                        Text(optionToString(selectable))

                        Spacer()

                        if selected.contains(where: { $0.id == selectable.id }) {
                            Image(systemName: "checkmark")
                        }
                    }
                }.tag(selectable.id)
            }
        }
    }

    private func toggleSelection(selectable: Selectable) {
        if let existingIndex = selected.firstIndex(where: { $0.id == selectable.id }) {
            selected.remove(at: existingIndex)
        } else {
            selected.insert(selectable)
        }
    }
}
