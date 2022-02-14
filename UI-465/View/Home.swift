//
//  Home.swift
//  UI-465
//
//  Created by nyannyan0328 on 2022/02/14.
//

import SwiftUI

struct Home: View {
    @State var progreess : CGFloat = 0.2
    @State var startAnimation : CGFloat = 0
    var body: some View {
        VStack{
            
            
            Image("p1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(10)
                .background(.white,in: Circle())
            
            
            Text(getAttributedString(string: "LION KING"))
                .font(.title.weight(.bold))
                .kerning(1.3)
            
            
            
            
            
            
            GeometryReader{proxy in
                
                
                let size = proxy.size
                
                
                
                ZStack{
                    
                    
                    
                    Image(systemName:"drop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(x: 1.3, y: 1)
                        .foregroundColor(.white)
                        .offset(y: -1)
                        .shadow(radius: 5)
                    
                    
                    
                    WaterWave(progress: progreess, waveHeight: 0.3, offset: startAnimation)
                        .fill(Color("Blue"))
                        .mask {
                            
                            Image(systemName:"drop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .overlay(alignment: .bottom) {
                            
                            
                            Button {
                                
                                progreess += 0.01
                                
                            } label: {
                                
                                Image(systemName: "plus")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(20)
                                    .background(.red,in: Circle())
                                    
                            }

                        }
                        
                    
                }
                .frame(width: size.width, height: size.height)
                .onAppear {
                    
                    
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){
                        
                        startAnimation = size.width
                    }
                }
                
                
                
            }
            .frame(height:300)
            
            
            Slider(value: $progreess)
           
                
        
            
            
            
        }
        .padding()
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
        .background(Color("BG"))
    }
    
    func getAttributedString(string : String) -> AttributedString{
        
        var atr = AttributedString(string)
        
        if let range = atr.range(of: "KING"){
            
            
            atr[range].foregroundColor = .red
            atr[range].font = .title.weight(.semibold)
        }
        
        return atr
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct WaterWave : Shape{
    
    var progress : CGFloat
    
    var waveHeight : CGFloat
    
    
    
    
    var offset : CGFloat
    
    var animatableData: CGFloat{
        
        
        get{offset}
        set{offset = newValue}
        
        
        
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            path.move(to:.zero)
            
            let progressHeight :  CGFloat = (1 - progress) * rect.height
            
            
            let height = waveHeight * rect.height
            
            
            for value in stride(from: 0, to: rect.width,by:2){
                
                
                let x : CGFloat = value
                
                let sine : CGFloat = sin(Angle(degrees: value + offset).radians)
                
                let y : CGFloat = (progressHeight + (height * sine))
                
                
                path.addLine(to: CGPoint(x: x, y: y))
                
                
            
                
            }
            
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
          
         
            
            
        }
    }
}
