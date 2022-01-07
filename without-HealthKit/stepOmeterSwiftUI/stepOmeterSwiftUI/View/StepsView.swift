import SwiftUI

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
                          .now() + 2) {
                     self.loadIndicator = false
                    }
                  }
              }
          }
      }














struct StepsView: View {
    
    //Dummy Data
    let steps = [
            "1000",
            "2000",
            "3000",
            "5000",
            "10000",
            "6000",
            "10000",
            
            
        ]
    
    
   
    var body: some View {
        
      

        
        ZStack{
//            List {
//                HStack{
//                    VStack(alignment: .leading){
//                        Text("steps")
//                            .font(.system(size: 25))
//                            .foregroundColor(.black)
//                        Text("date")
//                            .font(.system(size: 18))
//                            .foregroundColor(.black)
//                            .opacity(0.6)
//                           }
//                        Spacer()
//                        Image(systemName: "figure.walk")
//                }
//            }
            
            NavigationView {
                      List(steps, id: \.self) { step in
                          NavigationLink(destination: StepPopView(stepdata: step)) {
                              
                              
                              HStack{
                                VStack(alignment: .leading){
                                        Text(step)
                                            .font(.system(size: 25))
                                            .foregroundColor(.black)
                                        Text("Fake Date")
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
        }
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        LoadStepsView()
    }
}


struct StepPopView: View {
    let stepdata: String
    

    var body: some View {
        ZStack{
            Text("\(stepdata)")
                .font(.system(size: 100))
            
            if (stepdata == "10000")
            {
                LottieView(filename: "confetti")
                Text("Congratulation !")
                    .font(.system(size: 30))
                    .offset(x: 0, y: -100)
            }
            
            if (stepdata == "5000")
            {
                Text("Try Harder !!!")
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
