//
//  EventRowView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 26.01.2023.
//

import SwiftUI

struct EventRowView: View {
    
    let event: Event
    @EnvironmentObject var eventsVM: EventsViewModel
    @State var showInfo: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            calendar
            VStack {
                header
                if showInfo {
                    additionalInfo
                }
            }
            .padding(10)
            .foregroundColor(.white)
            .background(
                LinearGradient(colors: [Color.indigo, Color.purple], startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onTapGesture {
                withAnimation(.easeInOut) {
                    showInfo.toggle()
                }
            }
        }
    }
}

//struct EventRowView_Previews: PreviewProvider {
//    static var previews: some View {
//            EventRowView()
//    }
//}

extension EventRowView {
    var buttons: some View {
        VStack(alignment: .leading) {
            Text("Favorite")
            Text("Edit")
            Text("Delete")
        }
    }
    
    var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(event.name)
                Text(event.originalDate.formatted(date: .abbreviated, time: .omitted))
                    .opacity(0.5)
            }
            Spacer()
            Image(systemName: "chevron.down")
                .rotationEffect(Angle(degrees: showInfo ? 180 : 0))
        }
    }
    
    var additionalInfo: some View {
        HStack {
            Text(event.information)
            Spacer()
            RoundedRectangle(cornerRadius: 3)
                .frame(maxWidth: 1, maxHeight: 70)
            buttons
        }
    }
    
    var calendar: some View {
        ZStack {
            Color.blue
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    VStack {
                        Spacer()
                        Text("days")
                            .font(.footnote)
                            .padding(2)
                    }
                        .foregroundColor(.white)
                )
            Color.white
                .frame(width: 50, height: 35)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .offset(y: -7)
            Text(event.daysLeftToEvent.formatted())
                .font(.title2)
                .bold()
                .offset(y: -7)
        }
    }
}
