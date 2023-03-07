//
//  DaysToWidget.swift
//  DaysToWidget
//
//  Created by Danylo Ternovoi on 27.02.2023.
//


import WidgetKit
import Intents
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), events: EventModel.testEvents)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), events: EventModel.testEvents)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let calendar = Calendar.current
        let today: Date = calendar.startOfDay(for: Date())
        guard let nextUpdate = Calendar.current.date(byAdding: .day, value: 1, to: today) else {
            print("Error while fetching date")
            return
        }
        
        fetchEvents { events in
            let entry = SimpleEntry(date: today, events: events)
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }
    
    func fetchEvents(completion: @escaping ([EventModel]) -> ()) {
        
        self.authUserAccessGroup()
        guard let currentUser = Auth.auth().currentUser else {
            print("Error while loading user")
            completion([])
            return
        }
        let database = Firestore.firestore()
        let eventsRef = database.collection("users").document(currentUser.uid).collection("events")
        eventsRef.getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error while loading events: \(String(describing: error))")
                return
            }
            let allEvents = documents.compactMap { document -> EventModel? in
                do {
                    return try document.data(as: EventModel.self)
                } catch {
                    print("Error while decoding Event: \(error.localizedDescription)")
                    return nil
                }
            }
            let events = allEvents.sorted(by: { $0.daysTo < $1.daysTo })
            completion(events)
            print("Success: \(events[0].name)")
        }
    }
    
    func authUserAccessGroup() {
        do {
            try Auth.auth().useUserAccessGroup("MWQ8P93RWJ.com.danyloternovoi.DaysTo")
        } catch let error as NSError {
            print("Error changing user access group: %@", error)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let events: [EventModel]
}



struct DaysToWidgetEntryView : View {
    let dateCalculations = DateCalculationsModel()
    var entry: Provider.Entry
    
    var body: some View {
        let events = entry.events
        
        ZStack {
            Color.black
            
            if events == [] {
                progressionRingsView
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Upcoming:")
                        .font(.headline.weight(.bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                    ForEach(events.indices, id: \.self) { index in
                        if index <= 2 {
                            let event = events[index]
                            EventView(event: event)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 15)
                .padding(.vertical)
            }
        }
    }
    
    var progressionRingsView: some View {
        HStack {
            VStack(alignment: .center, spacing: 0) {
                ProgressRingView(allProgress: dateCalculations.getDaysInCurrentMonth(),
                                 leftProgress: dateCalculations.getDaysLeftCurrentMonth(),
                                 ringSize: 110,
                                 ringWidth: 10)
                Text("Month")
                    .font(.largeTitle.weight(.bold))
                Text("Days left: \(dateCalculations.getDaysLeftCurrentMonth())")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                ProgressRingView(allProgress: dateCalculations.getDaysInCurrentYear(),
                                 leftProgress: dateCalculations.getDaysLeftCurrentYear(),
                                 ringSize: 110,
                                 ringWidth: 10)
                Text("Year")
                    .font(.largeTitle.weight(.bold))
                Text("Days left: \(dateCalculations.getDaysLeftCurrentYear())")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .padding()
        .glassyFont(textColor: .white)
        .font(.headline.weight(.black))
    }
}

struct EventView: View {
    let event: EventModel
    
    var body: some View {
        HStack {
            Text(event.date.simpleDate(formatStyle: "d MMM"))
                .padding(2)
                .glassyFont(textColor: .black)
                .font(.caption2.weight(.bold))
                .frame(maxWidth: 65, maxHeight: 20)
                .background(
                    backgroundColor(daysLeft: event.daysTo)
                )
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    Text(event.name)
                        .glassyFont(textColor: .white)
                        .font(.caption2.weight(.heavy))
                    if event.isFavorite {
                        Image(systemName: "star.fill")
                            .font(.caption2.weight(.bold))
                            .foregroundColor(.yellow)
                            .offset(y: -2)
                    }
                }
                HStack {
                    Text(event.date.simpleDate(formatStyle: "dd.MM.yyyy"))
                        .glassyFont(textColor: .yellow.opacity(0.7))
                        .font(.caption2)
                    if !event.isFutureEvent {
                        Text("Age: \(event.age)")
                            .glassyFont(textColor: .white.opacity(0.7))
                            .font(.caption2)
                        
                    }
                }
            }
            Spacer()
            Text(event.daysTo == 0 ? "today" : "\(event.daysTo) D")
                .padding(.horizontal, 2)
                .glassyFont(textColor: .white)
                .font(.caption2.weight(.bold))
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
        }
    }
    
    func backgroundColor(daysLeft: Int) -> Color {
        switch daysLeft {
        case 0:
            return Color.green
        case 1...7:
            return Color.orange
        default:
            return Color.white
        }
    }
}

struct DaysToWidget: Widget {
    let kind: String = "DaysToWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DaysToWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("DaysTo Widget")
        .description("Don't miss any remarkable day in your life with a brand new Widget! Nevet before it was so easy!")
    }
}

struct DaysToWidget_Previews: PreviewProvider {
    static var previews: some View {
        DaysToWidgetEntryView(entry: SimpleEntry(date: Date(), events: EventModel.testEvents))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
