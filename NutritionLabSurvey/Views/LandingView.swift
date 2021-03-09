import SwiftUI

struct Landing {
    let imageName: String
    let title: String
}

struct LandingView: View {
    let pages: [Landing] = [
        Landing(imageName: "landing1", title: "Start questionnaire"),
        Landing(imageName: "landing2", title: "Purchase lab tests"),
        Landing(imageName: "landing3", title: "View lab results"),
        Landing(imageName: "landing4", title: "Get personalized recommendations"),
    ]

    @State var currentPage = 0
    
    @State var done = false {
        didSet { seen = done }
    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<self.pages.count) { index in
                    LandingViewTab(page: self.pages[index])
                        .tag(index)
                        .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle())
        
            HStack {
                Spacer()
                Button(action: {
                    if self.currentPage == pages.count - 1 {
                        done = true
                    } else {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            self.currentPage = (self.currentPage + 1)%self.pages.count
                        }
                    }
                }) {
                    Image(systemName: "arrow.right")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Circle().fill(Color.purple))
                }
            }
            .padding()
            NavigationLink(destination: HomeView(), isActive: $done) {
                EmptyView()
            }
            .hidden()
        }
    }
}

struct LandingViewTab: View {
    let page: Landing
    var body: some View {
        VStack {
            Spacer()
            Image(self.page.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
//            HStack {
                Text(self.page.title)
                    .font(.title)
                    .foregroundColor(.purple)
                Spacer()
//            }
            .padding()
        }
    }
}
