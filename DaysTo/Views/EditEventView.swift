//
//  EditEventView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 14.02.2023.
//

import SwiftUI

struct EditEventView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @AppStorage("appColorScheme") var appColorScheme: String = "Indigo"
    let namespace: Namespace.ID
    
    let eventID: String
    @State var eventName: String = ""
    @State var eventDescription: String = ""
    @State var eventDate: Date = Date()
    @State var isFavorite: Bool = false
    @State var isRepeated: Bool = false
    @State var valid: Bool = true

    var body: some View {
        VStack {
            VStack {
                Spacer()
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                topPanel
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 300, alignment: .leading)
            .background(
                Color(appColorScheme)
                    .matchedGeometryEffect(id: "background\(eventID)", in: namespace)
            )
            .mask(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(eventID)", in: namespace)
            )
            .shadow(color: .black, radius: 5)
            VStack(spacing: 20) {
                name
                dateAndToggles
                description
                saveButton
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
    }

    var topPanel: some View {
        HStack {
            Text(eventName)
                    .animatableFont(size: 18, weight: .heavy, design: .default)
                    .matchedGeometryEffect(id: "title\(eventID)", in: namespace)
                Spacer()
                Button {
                    withAnimation(.easeInOut) {
                        daysToVM.showEditEventView = false
                        daysToVM.eventToEdit = nil
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3.weight(.black))
                        .padding(10)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
        }
        .foregroundColor(.white)
    }
    
    var name: some View {
        TextField("Name", text: $eventName)
            .padding()
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
    
    var dateAndToggles: some View {
        VStack {
            DatePicker("Date", selection: $eventDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
            Divider()
            Toggle("Repeat every year", isOn: $isRepeated)
            Toggle("Make it favorite", isOn: $isFavorite)
        }
        .padding()
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
    
    var description: some View {
        TextEditor(text: $eventDescription)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .frame(maxHeight: 150)
            .colorMultiply(Color.gray.opacity(0.2))
    }
    
    var saveButton: some View {
        Button {
            withAnimation(.easeInOut) {
                daysToVM.editEvent(eventID: eventID,
                                   eventName: eventName,
                                   eventDescription: eventDescription,
                                   eventDate: eventDate,
                                   isFavorite: isFavorite,
                                   isRepeated: isRepeated)
                daysToVM.showEditEventView = false
                daysToVM.eventToEdit = nil
            }
        } label: {
            Text("save".uppercased())
                .padding()
                .font(.callout.weight(.black))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
    }
}

struct EditEventView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [.white, .indigo.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            EditEventView(namespace: namespace, eventID: "")
                .environmentObject(DaysToViewModel())
        }
    }
}
