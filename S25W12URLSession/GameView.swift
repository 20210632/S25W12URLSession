//struct GameView: View {
//    @State private var viewModel = GameViewModel()
//    @State private var showingAddSheet = false
//    
//    var body: some View {
//        NavigationStack(path: $viewModel.path) {
//            GameListView(viewModel: viewModel)
//            .navigationDestination(for: Game.self) { game in
//                GameDetailView(game: game)
//            }
//            .navigationTitle("게임")
//            .task {
//                await viewModel.loadGames()
//            }
//            .refreshable {
//                await viewModel.loadGames()
//            }
//            .toolbar {
//                Button {
//                    showingAddSheet.toggle()
//                } label: {
//                    Image(systemName: "plus.circle.fill")
//                }
//            }
//            .sheet(isPresented: $showingAddSheet) {
//                GameAddView(viewModel: viewModel)
//            }
//        }
//    }
//}
//
//struct GameListView: View {
//    let viewModel: GameViewModel
//    
//    func deleteGame(offsets: IndexSet) {
//        Task {
//            for index in offsets {
//                let game = viewModel.games[index]
//                await viewModel.deleteGame(game)
//            }
//        }
//    }
//    
//    var body: some View {
//        List{
//            ForEach(viewModel.games) { game in
//                NavigationLink(value: game) {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(game.title)
//                                .font(.headline)
//                            Text(game.genre)
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//            }
//            .onDelete(perform: deleteGame)
//        }
//    }
//}
//
//struct GameDetailView: View {
//    let game: Game
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 15) {
//                HStack {
//                    Text(game.genre)
//                        .font(.title2)
//                        .foregroundColor(.secondary)
//                    Spacer()
//                    Text(String(game.platform))
//                        .font(.title)
//                        .foregroundColor(.yellow)
//                }
//                .padding(.bottom, 10)
//
//                Text(game.description ?? "(평가 없음)")
//                    .font(.body)
//                    .multilineTextAlignment(.leading)
//            }
//            .padding()
//        }
//        .navigationTitle(game.title)
//        .navigationBarTitleDisplayMode(.large)
//    }
//}
//
//struct GameAddView: View {
//    let viewModel: GameViewModel
//    
//    @Environment(\.dismiss) var dismiss
//    
//    @State var title = ""
//    @State var genre = ""
//    @State var platform = ""
//    @State var description = ""
//    @State var image_url = ""
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("게임 정보 *")) {
//                    TextField("제목", text: $title)
//                    TextField("장르", text: $genre)
//                    TextField("판매처", text: $platform)
//                }
//                
//                Section(header: Text("설명")) {
//                    TextEditor(text: $image_url)
//                    TextEditor(text: $description)
//                        .frame(height: 150)
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("추가") {
//                        Task {
//                            await viewModel.addGame(
//                                Game(id: UUID(), title: title, genre: genre, platform: platform, description: description, image_url: image_url)
//                            )
//                            dismiss()
//                        }
//                    }
//                    .disabled(title.isEmpty || genre.isEmpty)
//                }
//                
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("취소") {
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//}
