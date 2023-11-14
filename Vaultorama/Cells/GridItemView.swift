import SwiftUI

struct GridItemView: View {
    
    @State private var isHovered = false
    
    let size: Double
    let file: URL

    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: file) { image in
                image
                    .resizable()
                    .aspectRatio(1,contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
        }
        .frame(width: size, height: size)
        .overlay(
            VStack {
                if isHovered {
                    VStack {
                               HStack {
                                   Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                   Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                      Image(systemName: "hand.thumbsup.fill")
                                           .foregroundColor(.yellow)
                                           .padding(8)
                                           .background(Color.white)
                                           .cornerRadius(10)
                                   })
                                   .buttonStyle(.plain)
                   
                                   Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                      Image(systemName: "folder.fill")
                                           .foregroundColor(.yellow)
                                           .padding(8)
                                           .background(Color.white)
                                           .cornerRadius(10)
                                   })
                                   .buttonStyle(.plain)
                               }.padding(10)
                   
                               Spacer()
                           }

                } else {
                    EmptyView()
                }
            }
        )
        .onHover(perform: { hovering in
                        withAnimation {
                            isHovered = hovering
                        }
                    })
       
        
       
        
        
       
    
       
//        Color.black.opacity(isHovered ? 0.2 : 0)
//        
//        VStack {
//            HStack {
//                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
//                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                   Image(systemName: "hand.thumbsup.fill")
//                        .foregroundColor(.yellow)
//                        .padding(8)
//                        .background(Color.white)
//                        .cornerRadius(10)
//                }) 
//                .buttonStyle(.plain)
//                
//                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                   Image(systemName: "folder.fill")
//                        .foregroundColor(.yellow)
//                        .padding(8)
//                        .background(Color.white)
//                        .cornerRadius(10)
//                })
//                .buttonStyle(.plain)
//            }.padding(10)
//            
//            Spacer()
//        }
//        .overlay(VStack {
//                if isHovered {
//                    Rectangle()
//                        .fill(.blue)
//                        .stroke(Color.blue, lineWidth: 2)
//                } else {
//                    EmptyView()
//                }
//            })
//        .opacity(isHovered ? 0.2 : 0)
    }
    
}






//
//
//struct ImageCard: View {
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16.0) {
//            Image("placeholder")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
////                .frame(width: 240, height: 200)
//                cardText.padding(.horizontal, 0)
//        }
//        .background(.white)
//        .clipShape(RoundedRectangle(cornerRadius: 5.0))
//        .shadow(radius: 8.0)
//    }
//
//    var cardText: some View {
//        VStack(alignment: .leading, spacing: 4.0) {
//            Text("Evening Workout").font(.headline).colorInvert()
//            HStack(spacing: 4.0) {
//                Image(systemName: "clock.arrow.circlepath")
//                Text("50 min")
//            }.foregroundColor(.gray)
//        }.padding()
//    }
//}


#Preview {
    ContentView()
}
