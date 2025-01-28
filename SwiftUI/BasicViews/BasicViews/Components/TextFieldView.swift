import SwiftUI

struct TextFieldView: View {
    
    @State var name: String = ""
    @State var password: String = ""
    
    // TextField의 focus 관리
    @FocusState var focusField: Field?
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .focused($focusField, equals: .name)
                .onSubmit {
                    focusField = .password
                }
            
            TextField("PW", text: $password)
                .focused($focusField, equals: .password)
                .onSubmit {
                    _ = checkTextField()
                }
            
            Button("Login") {
                _ = checkTextField()
            }
        }
        .onAppear {
            focusField = .name
        }
    }
    
    private func checkTextField() -> Bool {
        if name.isEmpty {
            focusField = .name
        } else if password.isEmpty {
            focusField = .password
        } else {
            focusField = nil
            // API call
        }
        
        return !name.isEmpty && !password.isEmpty
    }
}

extension TextFieldView {
    
    enum Field: Hashable {
        case name
        case password
    }
}

#Preview {
    TextFieldView()
}
