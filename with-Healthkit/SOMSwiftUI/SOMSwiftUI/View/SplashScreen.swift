//
//  SplashScreen.swift
//  stepOmeterSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 06/01/22.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
           
            ZStack{
            
            Image("title")
                    .resizable()
                    .frame(width: 400, height: 120)
                    .offset(x: 0, y: -250)
                
                
            LottieView(filename: "groovy")
                
//            LottieView(filename: "cloader")
//                    .frame(width: 80, height: 80)
//                    .offset(x: 0, y: 250)
                
                Indicator()
                    .offset(x: 0, y: 250)
                
            }.padding()
            
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

