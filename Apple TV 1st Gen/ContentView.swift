//
//  ContentView.swift
//  Apple TV 1st Gen
//
//  Created by Zane Kleinberg on 6/28/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HStack {
                    lefthand_view().frame(width: geometry.size.width/2, height: geometry.size.height)
                    righthand_view().frame(width: geometry.size.width/2, height: geometry.size.height)
                }
            }
        }
    }
}

struct righthand_view: View {
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                tv_header()
                Spacer().frame(height: 30)
                selected_item(text: "Movies").frame(height: 60).padding([.leading, .trailing], 40)
                unselected_item(text: "TV Shows").frame(height: 60).padding([.leading, .trailing], 40)
                unselected_item(text: "Music").frame(height: 60).padding([.leading, .trailing], 40)
                unselected_item(text: "Podcasts").frame(height: 60).padding([.leading, .trailing], 40)
                unselected_item(text: "Photos").frame(height: 60).padding([.leading, .trailing], 40)
                unselected_item(text: "Settings").frame(height: 60).padding([.leading, .trailing], 40)
                unselected_item(text: "Sources").frame(height: 60).padding([.leading, .trailing], 40)
                Spacer().frame(height: 100)
            }
        }
    }
}

struct tv_header: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            Spacer()
            ZStack {
                Text("").fontWeight(.bold).font(.system(size: 80)).foregroundColor(.white).blur(radius: 10)
                Text("").fontWeight(.bold).font(.system(size: 80)).foregroundColor(.white)
            }
            Text("tv").font(Font.custom("Myriad Pro Semibold", size: 80)).foregroundColor(.white)
            Spacer()
        }
    }
}

struct selected_item: View {
    var text: String
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle().fill(Color(red: 43/255, green: 75/255, blue: 121/255))
                Rectangle().fill(Color.black).frame(width: geometry.size.width, height: geometry.size.height).border(Color(red: 38/255, green: 79/255, blue: 142/255), width: 2).glow(color: Color(red: 43/255, green: 75/255, blue: 121/255).opacity(0.5), radius: 30)
                VStack(spacing: 0) {
                    Rectangle().fill(LinearGradient(gradient: Gradient(stops: [.init(color: Color(red: 116/255, green: 115/255, blue: 112/255), location: 0), .init(color: Color(red: 53/255, green: 53/255, blue: 53/255), location: 1)]), startPoint: .top, endPoint: .bottom)).frame(width: geometry.size.width-4, height: geometry.size.height/2.5).cornerRadiusSpecific(radius: 4, corners: [.bottomLeft, .bottomRight]).padding([.top], 2)
                    Spacer()
                }
                VStack(spacing: 0) {
                    Spacer()
                    Rectangle().fill(LinearGradient(gradient: Gradient(stops: [.init(color: Color(red: 59/255, green: 59/255, blue: 59/255), location: 0), .init(color: Color(red: 25/255, green: 25/255, blue: 25/255), location: 1)]), startPoint: .bottom, endPoint: .top)).frame(width: geometry.size.width-4, height: geometry.size.height/6.5).cornerRadiusSpecific(radius: 4, corners: [.topLeft, .topRight]).padding([.bottom], 2)
                }
                HStack {
                    Text(text).font(Font.custom("Lucida Grande Bold", size: 30)).foregroundColor(.white).padding(.leading, 20)
                    Spacer()
                    ZStack {
                        Image(systemName: "chevron.right").font(.system(size: 25, weight: .heavy)).foregroundColor(.white).padding(.trailing, 20).blur(radius: 5)
                        Image(systemName: "chevron.right").font(.system(size: 25, weight: .heavy)).foregroundColor(.white).padding(.trailing, 20)
                    }
                }
            }
        }
    }
}

struct unselected_item: View {
    var text: String
    var body: some View {
        ZStack {
            HStack {
                Text(text).font(Font.custom("Lucida Grande Bold", size: 30)).foregroundColor(.white).padding(.leading, 20)
                Spacer()
                Image(systemName: "chevron.right").font(.system(size: 25, weight: .heavy)).foregroundColor(Color(red: 133/255, green: 133/255, blue: 133/255)).padding(.trailing, 20)
            }
        }
    }
}

struct lefthand_view: View {
    var body: some View {
        ZStack {
            //Smaller Music Icon
            VStack {
                HStack {
                    ZStack {
                        Image("MusicIcon").blur(radius: 20)
                        Image("MusicIcon").rotationEffect(.degrees(-180)).rotation3DEffect(
                            .degrees(180),
                            axis: (x:0, y: 1, z: 0)
                        ).offset(y:-110 + 512).opacity(0.05)
                    }.scaleEffect(0.30).padding(.top, 75).offset(x:-165)
                    Spacer()
                }
                Spacer()
            }.clipped()
            //Smaller TV Icon
            VStack {
                ZStack {
                    Image("TvIcon").blur(radius: 20)
                    Image("TvIcon").rotationEffect(.degrees(-180)).rotation3DEffect(
                        .degrees(180),
                        axis: (x:0, y: 1, z: 0)
                    ).offset(y:-110 + 512).opacity(0.25)
                }.scaleEffect(0.40).padding(.top, 115).padding(.trailing, 280)
                Spacer()
            }
            
            //Larger Movie Icon
            HStack {
                Spacer()
                ZStack {
                    Image("MoviesIcon")
                    Image("MoviesIcon").rotationEffect(.degrees(-180)).rotation3DEffect(
                        .degrees(180),
                        axis: (x:0, y: 1, z: 0)
                    ).offset(y:-110 + 512).opacity(0.25)
                }
            }
        }
    }
}

//** MARK: Extensions

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {
        
        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadiusSpecific(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}


extension View {
    func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
