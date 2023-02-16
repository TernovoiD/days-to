//
//  EventRowView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 14.02.2023.
//

import SwiftUI

struct EventRowView: View {
    @EnvironmentObject var daysToVM: DaysToViewModel
    @AppStorage("askBeforeDelete") var askBeforeDelete: Bool = true
    @AppStorage("appColorScheme") var appColorScheme: String = "Indigo"
    @State var showDeleteConfirmationAlert: Bool = false
    @State var showFullPanel: Bool = false
    let namespace: Namespace.ID
    let event: EventModel
    
    var body: some View {
        VStack(alignment: .leading) {
            panelContent
            if daysToVM.selectedEvent == event {
                additionalInfo
                    .padding(.top, 20)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.white)
        .background(
            Color(appColorScheme)
                .matchedGeometryEffect(id: "background\(event.id)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .matchedGeometryEffect(id: "mask\(event.id)", in: namespace)
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                if daysToVM.selectedEvent == event {
                    daysToVM.selectedEvent = nil
                } else {
                    daysToVM.selectedEvent = event
                }
            }
        }
        .shadow(color: . black.opacity(0.5), radius: 3, y: 3)
        .padding(.horizontal)
    }
    
    var panelContent: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(event.name)
                        .animatableFont(size: 18, weight: .heavy, design: .default)
                        .matchedGeometryEffect(id: "title\(event.id)", in: namespace)
                    if event.isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .font(.headline)
                Text("\(event.daysTo) days")
                    .animatableFont(size: 16, weight: .heavy, design: .default)
                    .opacity(0.6)
            }
            Spacer()
            Image(systemName: "chevron.down")
                .rotationEffect(.degrees(showFullPanel ? 180 : 0))

        }
    }
    
    var additionalInfo: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Date: \(event.date.formatted(date: .abbreviated, time: .omitted))")
                if event.description == "" {
                    Text("No additional information")
                } else {
                    Text(event.description)
                }
            }
            Spacer()
            RoundedRectangle(cornerRadius: 1, style: .continuous)
                .padding(.top, 5)
                .frame(maxWidth: 1, maxHeight: 90)
                .opacity(0.3)
            eventPanelButtons
        }
    }
    
    var eventPanelButtons: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button {
                withAnimation(.easeInOut) {
                    daysToVM.showEditEventView = true
                    daysToVM.eventToEdit = event
                }
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            Button {
                withAnimation(.spring()) {
                    daysToVM.toggleEventFavoriteStatus(event: event)
                }
            } label: {
                Label("Favorite", systemImage: event.isFavorite ? "star.fill" : "star")
            }
            Button {
                if askBeforeDelete {
                    withAnimation(.easeInOut) {
                        showDeleteConfirmationAlert = true
                    }
                } else {
                    withAnimation(.easeInOut) {
                        daysToVM.deleteEvent(event: event)
                    }
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .alert("Are you shoure to delete this Event?", isPresented: $showDeleteConfirmationAlert) {
                Button("DELETE", role: .destructive) {
                    withAnimation(.easeInOut) {
                        daysToVM.deleteEvent(event: event)
                    }
                }
            }
        }
    }
}

struct EventRowView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        EventRowView(namespace: namespace, event: EventModel.testEvents[0])
            .environmentObject(DaysToViewModel())
    }
}
