//
//  ContentView.swift
//  stepOmeterSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 06/01/22.
//

import SwiftUI

struct ContentView: View {
    @State var splashScreen  = true

    var body: some View {
         ZStack{
            Group{
              if splashScreen {
                  SplashScreen()
               }
              else{
                  MainView()
                    }
                }
               .onAppear {
                  DispatchQueue
                       .main
                       .asyncAfter(deadline:
                                        .now() + 3.5) {
                   self.splashScreen = false
                  }
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        

    }
}

//Done End
