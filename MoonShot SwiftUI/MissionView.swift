//
//  MissionView.swift
//  MoonShot SwiftUI
//
//  Created by Frimpong Anorchie II on 16/03/2021.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember{
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                VStack{
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role){ CrewMember in
                        NavigationLink(destination: AstronautView(astronaut: CrewMember.astronaut)){
                            HStack{
                                Image(CrewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                                    Text(CrewMember.astronaut.name)
                                        .font(.headline)
                                    
                                    Text(CrewMember.role)
                                        .foregroundColor(.secondary)
                                })
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            })
            
        }
        .navigationBarTitle(self.mission.displayName)
    }
    
    
    init(mission: Mission, astrouauts: [Astronaut]) {
        
        self.mission = mission
        var matches = [CrewMember]()
        
        for member in mission.crew{
            if let match = astrouauts.first(where: { $0.id == member.name}){
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else{
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astrouauts: astronauts)
    }
}
