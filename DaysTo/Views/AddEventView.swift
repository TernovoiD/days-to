//
//  AddEventView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 26.01.2023.
//

import SwiftUI

struct AddEventView: View {
    
    @EnvironmentObject var eventsVM: EventsViewModel
    @Binding var isPresented: Bool
    @State var newName: String = ""
    @State var newDate: Date = Date()
    @State var isRepeated: Bool = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                TextField("Add name...", text: $newName)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .autocorrectionDisabled(true)
                DatePicker(selection: $newDate, displayedComponents: .date) {
                    Text("Choose Date")
                }
                Toggle("Repeat every year", isOn: $isRepeated)
                Button {
                    eventsVM.addEvent(withName: newName, andInformation: "", andDate: newDate, andFavoriteStatus: false, andRepeatStatus: isRepeated)
                    isPresented = false
                } label: {
                    Text("SAVE")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Spacer()
                Image(systemName: "person.3.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(1.2)
                    .offset(y: 35)
            }
            .padding()
            .navigationTitle("Add Event")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        isPresented = false
                    } label: {
                        HStack {
//                            Image(systemName: "xmark")
                            Text("Cancel")
                        }
                    }
                    
                }
            }
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(isPresented: .constant(true))
    }
}
