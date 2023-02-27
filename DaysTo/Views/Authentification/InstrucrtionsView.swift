//
//  InstrucrtionsView.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 27.02.2023.
//

import SwiftUI

struct InstrucrtionsView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .background(.ultraThinMaterial)
                    .frame(width: 60, height: 15)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .frame(height: 316)
            TabView {
                step1
                step2
                step3
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 350)
        }
    }
    
    var step1: some View {
        VStack(alignment: .leading, spacing: 10) {
                Image(systemName: "calendar.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.linearGradient(colors: [.indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(height: 150)
            Text("Create Event")
                .font(.headline.weight(.heavy))
            Text("Birthday, wedding, the day you found your love or will become graduated. Any future or past event can be added!")
                .font(.subheadline)
                .glassyFont(textColor: .primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    var step2: some View {
        VStack(alignment: .leading, spacing: 10) {
                Image(systemName: "list.bullet.rectangle.portrait")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.linearGradient(colors: [.red, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(height: 150)
                    .frame(maxWidth: .infinity, alignment: .center)
            Text("Track Events")
                .font(.headline.weight(.heavy))
            Text("DaysTo will show your events as a handy list with nearest events always on top!")
                .font(.subheadline)
                .glassyFont(textColor: .primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    var step3: some View {
        VStack(alignment: .leading, spacing: 10) {
                Image(systemName: "platter.filled.top.iphone")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.linearGradient(colors: [.mint, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(height: 150)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            Text("Add Widget")
                .font(.headline.weight(.heavy))
            Text("Don't miss any remarkable day in your life with a brand new Widget! Nevet before it was so easy!")
                .font(.subheadline)
                .glassyFont(textColor: .primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

struct InstrucrtionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstrucrtionsView()
    }
}
