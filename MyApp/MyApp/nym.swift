import SwiftUI

struct NymView: View {
    var body: some View {
        TabView {
            MemoryGame()
                .tabItem {
                    Label("Memory", systemImage: "brain")
                }
            
            MatchGame()
                .tabItem {
                    Label("Allumettes", systemImage: "pencil")
                }
        }
    }
}

struct MatchGame: View {
    @State private var matches = Array(repeating: true, count: 21)
    @State private var isPlayer1Turn = true
    @State private var selectedMatches = 0
    @State private var gameOver = false
    @State private var winner = ""
    
    var remainingMatches: Int {
        matches.filter { $0 }.count
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Circle()
                    .fill(isPlayer1Turn ? Color.green : Color.gray)
                    .frame(width: 20, height: 20)
                Text("Vous")
                
                Spacer()
                
                Text("invité")
                Circle()
                    .fill(isPlayer1Turn ? Color.gray : Color.green)
                    .frame(width: 20, height: 20)
            }
            .padding()
            
            
            Text("Allumettes restantes: \(remainingMatches)")
                .font(.headline)
                .padding()
            
            
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 30))
            ], spacing: 10) {
                ForEach(0..<matches.count, id: \.self) { index in
                    if matches[index] {
                        MatchView()
                            .onTapGesture {
                                selectMatch(at: index)
                            }
                    }
                }
            }
            .padding()
            
            
            VStack {
                Text("Allumettes sélectionnées: \(selectedMatches)")
                    .padding()
                
                HStack {
                    Button("Prendre les allumettes") {
                        takeMatches()
                    }
                    .disabled(selectedMatches == 0)
                    .buttonStyle(.bordered)
                    
                    Button("Réinitialiser la sélection") {
                        selectedMatches = 0
                    }
                    .disabled(selectedMatches == 0)
                    .buttonStyle(.bordered)
                }
            }
            .padding()
        }
        .alert("Fin de la partie", isPresented: $gameOver) {
            Button("Nouvelle partie", action: resetGame)
        } message: {
            Text(winner)
        }
    }
    
    private func selectMatch(at index: Int) {
        if selectedMatches < 3 && matches[index] {
            matches[index] = false
            selectedMatches += 1
        }
    }
    
    private func takeMatches() {
        if selectedMatches > 0 {
            isPlayer1Turn.toggle()
            selectedMatches = 0
            
            if remainingMatches == 0 {
                winner = isPlayer1Turn ? "L'invité a gagné !" : "vous avez gagné !"
                gameOver = true
            }
        }
    }
    
    private func resetGame() {
        matches = Array(repeating: true, count: 21)
        isPlayer1Turn = true
        selectedMatches = 0
        gameOver = false
        winner = ""
    }
}

struct MatchView: View {
    var body: some View {
        VStack {
            
            Rectangle()
                .fill(Color.red)
                .frame(width: 8, height: 12)
            
            
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 4, height: 40)
        }
    }
}

struct NymView_Previews: PreviewProvider {
    static var previews: some View {
        NymView()
    }
}
