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
    @State var valid: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            topPanel
            if !valid {
                Text("Name must contain at least 3 latters")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.red)
            }
            name
            Divider()
            calendar
            Divider()
            toggles
            saveButton
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .shadow(radius: 5, y: 5)
        .padding()
    }
    
    var topPanel: some View {
        HStack {
            Text("Add Event")
                .font(.title.weight(.bold))
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
            Spacer()
            Button {
                withAnimation(.easeInOut) {
                    daysToVM.showAddEventView = false
                    clearFields()
                    valid = true
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
        TextField("Name...", text: $eventName)
            .font(.callout.weight(.black))
            .padding()
//            .foregroundColor(.indigo)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .autocorrectionDisabled(true)
    }
    
    var calendar: some View {
        DatePicker("Date", selection: $eventDate, displayedComponents: .date)
            .datePickerStyle(.compact)
    }
    
    var toggles: some View {
        VStack {
                Toggle("Repeat every year", isOn: $isRepeated)
                Toggle("Make it favorite", isOn: $isFavorite)
        }
    }
    
    var background: some View {
        LinearGradient(colors: [.indigo, .clear], startPoint: .top, endPoint: .bottom)
    }
    
    var saveButton: some View {
        Button {
            createNewEvent()
        } label: {
            Text("save".uppercased())
                .padding()
                .font(.callout.weight(.black))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(valid ? Color.blue : Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
    }

    func createNewEvent() {
        withAnimation(.easeInOut) {
            if eventName.count < 3 {
                valid = false
            } else {
                valid = true
                daysToVM.addEvent(name: eventName, description: eventDescription, date: eventDate, isFavorite: isFavorite, isRepeated: isRepeated)
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
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [.purple, .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            AddEventView()
                .environmentObject(DaysToViewModel())
        }
    }
}
