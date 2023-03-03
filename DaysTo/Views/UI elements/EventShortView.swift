//
//  EventShortView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 01.03.2023.
//

import SwiftUI

struct EventShortView: View {
    let event: EventModel
    
    var body: some View {
        HStack {
            Text(event.date.simpleDate(formatStyle: "d MMM"))
                .padding(5)
                .glassyFont(textColor: .black)
                .font(.subheadline.weight(.bold))
                .frame(maxWidth: 70, maxHeight: 25)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            VStack(alignment: .leading) {
                HStack {
                    Text(event.name)
                        .glassyFont(textColor: .white)
                        .font(.subheadline.weight(.bold))
                    if event.isFavorite {
                    Image(systemName: "star.fill")
                        .font(.caption2.weight(.bold))
                        .foregroundColor(.yellow)
                    }
                }
                HStack {
                    if !event.isFutureEvent {
                        Text("Age: \(event.age)")
                            .glassyFont(textColor: .white.opacity(0.7))
                            .font(.caption2.weight(.bold))
                        
                    }
                    Text(event.date.simpleDate(formatStyle: "dd.mm.yyyy"))
                        .glassyFont(textColor: .yellow.opacity(0.7))
                        .font(.caption2.weight(.bold))
                }
            }
            Spacer()
                Text("\(event.daysTo) D")
                .padding(.vertical, 1)
                .padding(.horizontal, 5)
                .glassyFont(textColor: .white)
                .font(.caption.weight(.bold))
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
        }
    }
}

struct EventShortView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.indigo
                .ignoresSafeArea()
            EventShortView(event: EventModel.testEvents[0])
        }
    }
}
