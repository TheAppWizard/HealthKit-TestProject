//
//  StepsView.swift
//  stepOmeterSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 06/01/22.
//

import SwiftUI
import HealthKit

struct LoadStepsView: View {
    @State var loadIndicator  = true

      var body: some View {
           ZStack{
              Group{
                if loadIndicator {
                    Indicator()
                 }
                else{
                    StepsView()
                      }
                  }
                 .onAppear {
                    DispatchQueue
                         .main
                         .asyncAfter(deadline:
                          .now() + 1) {
                     self.loadIndicator = false
                    }
                  }
              }
          }
      }


struct StepsView: View {
    
//    //Dummy Data
//    let steps = [
//            "1000",
//            "2000",
//            "3000",
//            "5000",
//            "10000",
//            "6000",
//            "10000",
//
//
//        ]
//
//
//
//    var body: some View {
//
//
//
//
//        ZStack{
//
//            NavigationView {
//                      List(steps, id: \.self) { step in
//                          NavigationLink(destination: StepPopView(stepdata: step)) {
//
//
//                              HStack{
//                                VStack(alignment: .leading){
//                                        Text(step)
//                                            .font(.system(size: 25))
//                                            .foregroundColor(.black)
//                                        Text("6 / 1 / 2021")
//                                             .font(.system(size: 15))
//                                             .foregroundColor(.black)
//                                              .opacity(0.6)
//                                        }
//                                        Spacer()
//                                        Image(systemName: "figure.walk")
//                                              }
//                          }
//                      }
//                      .navigationTitle("Weekly Steps")
//                  }
//        }
//    }
    
    
    
    //To Save Step Data
    @State private var steps : [Step] = [Step]()
    
    
    private var healthStore : HealthStore?
    
    init(){
        healthStore = HealthStore()
    }
    
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection){
        
        //start date : 7 days ago
        let startDate = Calendar.current.date(byAdding: .day,value: -7, to: Date())!
        
        //end date : Current Date
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) {(statistics , stop) in
            
            //Access number of count
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
            
            
        }
    }
    //
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
                        NavigationView {
                                  List(steps, id: \.id) { step in
//                                    NavigationLink(destination: StepPopView(stepdata: step)) {
                                      NavigationView {
            
                                          HStack{
                                            VStack(alignment: .leading){
                                                 Text("\(step.count)")
                                                        .font(.system(size: 25))
                                                        .foregroundColor(.black)
                                                Text(step.date,style: .date)
                                                         .font(.system(size: 15))
                                                         .foregroundColor(.black)
                                                          .opacity(0.6)
                                                    }
                                                    Spacer()
                                                    Image(systemName: "figure.walk")
                                            }
                                      }
                                  }
                                  .navigationTitle("Weekly Steps")
                              }

            
            
            
//            Text("Hello World").padding()
                .onAppear{
                    if let healthStore = healthStore {
                        healthStore.requestAuthorization{
                            success in
                            
                            if success {
                                healthStore.calculateSteps{
                                    statisticsCollection in
                                    
                                    if let statisticsCollection = statisticsCollection {
                                     // Update my UI
//                                      print(statisticsCollection)
                                        
                                        updateUIFromStatistics(statisticsCollection)
                                        
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            
        }
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        LoadStepsView()
    }
}


struct StepPopView: View {
    
//    @State var settings = SettingsView()
    
    let stepdata: String

    

    var body: some View {
        ZStack{
            VStack{
                Text("\(stepdata)")
                    .font(.system(size: 100))
                
                
//                Text("\(settings.getData)")
//                    .font(.system(size: 100))
            }
            
            if (stepdata == "10000")
            {
                LottieView(filename: "confetti")
                Text("Congratulation !")
                    .font(.system(size: 30))
                    .offset(x: 0, y: -100)
            }
        }
    }
}


//MARK: Fetch Indicator

struct Indicator: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        
    }
}


