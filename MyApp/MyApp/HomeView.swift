import SwiftUI

struct HomeView: View {
    var body: some View {
        HStack(spacing: 20) {
            
            NavigationLink(destination: MemoryGame()) {
                VStack {
                    Image(systemName: "brain")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    Text("MemoryGame")
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
            .padding()

            NavigationLink(destination: MatchGame()) {
                VStack {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    Text("MatchGame")
                        .font(.caption)
                        .foregroundColor(.black) 
                }
            }
            .padding()

        }
        .navigationTitle("Accueil")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
