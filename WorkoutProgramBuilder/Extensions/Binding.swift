import SwiftUI

extension Binding {
    func binding<Element>(for element: Element) -> Binding<Element>
        where Value == [Element], Element: Identifiable
    {
        Binding<Element>.init(
            get: { element },
            set: { element in
                guard let index = wrappedValue.firstIndex(where: { $0.id == element.id }) else {
                    fatalError("❌ Expected to find index of element in sequence.")
                }

                wrappedValue[index] = element
            }
        )
    }
}
