//
//  AddEventView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 03.02.2023.
//

import SwiftUI

struct AddEventView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @State var eventName: String = ""
    @State var eventDescription: String = ""
    @State var eventDate: Date = Date()
    @State var isFavorite: Bool = false
    @State var isRepeated: Bool = false
    @State var error: String = ""
    @FocusState var selectedField: FocusText?
    
    enum FocusText {
        case name
    }
    
    var isFormValid: Bool {
        if eventName.isEmpty {
            error = "Field cannot be empty."
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        VStack {
            topPanel
            Spacer()
            VStack(spacing: 15) {
                Text("Add Event", comment: "Add Event screen title")
                    .font(.largeTitle.weight(.bold))
                    .glassyFont(textColor: .primary)
                name
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .frame(maxHeight: 1)
                    .opacity(0.2)
                datePicker
                toggles
            }
            Spacer()
            Text(error)
                .font(.headline.weight(.bold))
                .glassyFont(textColor: .red)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            saveButton
        }
        .padding()
        .background()
        .onTapGesture {
            selectedField = .none
        }
    }
    
    var topPanel: some View {
        HStack {
            Spacer()
            Button {
                withAnimation(.easeInOut) {
                    selectedField = .none
                    daysToVM.showAddEventView = false
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.title3.weight(.black))
                    .padding(10)
                    .foregroundColor(.primary)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
        }
    }
    
    var name: some View {
        TextField("Name", text: $eventName)
                .padding()
                .background()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .selectedField(colors: selectedField == .name ? [.indigo, .blue] : [.clear, .clear])
                .autocorrectionDisabled(true)
                .focused($selectedField, equals: .name)
                .submitLabel(.next)
                .onSubmit {
                    selectedField = .none
                }
                .onTapGesture {
                    selectedField = .name
                }
    }
    
    var toggles: some View {
        VStack {
            Toggle("Repeat every year", isOn: $isRepeated)
            Toggle("Make it favorite", isOn: $isFavorite)
        }
    }
    
    var datePicker: some View {
        DatePicker("Date", selection: $eventDate, displayedComponents: .date)
            .datePickerStyle(.compact)
    }
    
    var saveButton: some View {
        Button {
            createNewEvent()
        } label: {
            Text("Add", comment: "Button that leads to create new Event")
                .padding()
                .font(.callout.weight(.black))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
    }

    func createNewEvent() {
        if isFormValid {
            withAnimation(.easeInOut) {
                daysToVM.addEvent(name: eventName, description: eventDescription, date: eventDate, isFavorite: isFavorite, isRepeated: isRepeated)
                daysToVM.reloadWidget()
                daysToVM.showAddEventView = false
                clearFields()
            }
        }
    }
    
    func clearFields() {
        eventName = ""
        eventDescription = ""
        eventDate = Date()
        isFavorite = false
        isRepeated = false
        error = ""
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
            AddEventView()
                .environmentObject(DaysToViewModel())
    }
}
