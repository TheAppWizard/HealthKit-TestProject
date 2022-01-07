//
//  SettingsView.swift
//  stepOmeterSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 06/01/22.
//  Save Here

import SwiftUI


//var setgoal = ["1000"
//        ,"2000","3000","4000","5000","6000","7000","8000","9000","10000","15000","20000","25000"]

struct SettingsView: View {
    @State private var stepnumber = ""
    @State private var getData = ""

    var body: some View {
        ZStack{
            
            Color.gray.opacity(0.01).edgesIgnoringSafeArea(.all)
        
            Text("Set Goals")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .font(.system(size: 38))
                .offset(x: -87, y: -280)
            
            
            VStack(alignment: .leading) {
                TextField(" Enter Number of Steps" ,text: $stepnumber  )
                Text("Steps : \(stepnumber)")
             
                //  To Show Saved Data
                Text("\(getData)" )
                    .font(.system(size: 50))
                
             Spacer()
             Button(action: {saveValue()}){
                    Text("Save")
                }
            }
            
            .padding()
            .background(.white)
            .frame(width: 250, height: 250)
            .overlay {
                RoundedRectangle(cornerRadius: 12).stroke(.blue, lineWidth: 2)
                }
            .onAppear (perform: {
                getValue()
            })
            
        }
        
        
    }
    
    func saveValue(){
        UserDefaults.standard.set(self.stepnumber,forKey: "save")
    }
    
    
    func getValue(){
        getData = "\(UserDefaults.standard.string(forKey: "save") ?? "")"
    }
}
 

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
