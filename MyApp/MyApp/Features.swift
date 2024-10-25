import SwiftUI

struct MemoryGame: View {
    @State private var emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"]
    @State private var cards: [Card] = []
    @State private var flippedCards = Set<Int>()
    @State private var matchedCards = Set<Int>()
    @State private var isProcessing = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init() {
        _cards = State(initialValue: (emojis + emojis)
            .shuffled()
            .enumerated()
            .map { Card(id: $0, content: $1) })
    }
    
    var body: some View {
        VStack {
            Text("Jeu de Mémoire V2")
                .font(.largeTitle)
                .padding()
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(cards) { card in
                    CardView(card: card,
                            isFlipped: flippedCards.contains(card.id),
                            isMatched: matchedCards.contains(card.id))
                        .onTapGesture {
                            if !isProcessing {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    flipCard(card.id)
                                }
                            }
                        }
                }
            }
            .padding(10)
        }
    }
    
    func flipCard(_ index: Int) {
        
        if !flippedCards.contains(index) && !matchedCards.contains(index) {
            
            if flippedCards.count == 2 {
                flippedCards.removeAll()
            }
            
            flippedCards.insert(index)
            
            
            if flippedCards.count == 2 {
                isProcessing = true
                let flippedIndices = Array(flippedCards)
                
                
                if cards[flippedIndices[0]].content == cards[flippedIndices[1]].content {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            matchedCards.formUnion(flippedCards)
                        }
                        isProcessing = false
                    }
                } else {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            flippedCards.removeAll()
                        }
                        isProcessing = false
                    }
                }
            }
        }
    }
}

struct Card: Identifiable {
    let id: Int
    let content: String
}

struct CardView: View {
    let card: Card
    let isFlipped: Bool
    let isMatched: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(isFlipped ? Color.white : Color.blue)
                .overlay(
                    Group {
                        if isFlipped {
                            Text(card.content)
                                .font(.largeTitle)
                        }
                    }
                )
        }
        .frame(width: 70, height: 100)
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .opacity(isMatched ? 0.5 : 1)
    }
}

struct MemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGame()
    }
}
