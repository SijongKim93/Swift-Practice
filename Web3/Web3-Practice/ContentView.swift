import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WalletViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("코인 지갑앱")
                .font(.largeTitle)
                .padding(.top, 40)
            
            TextField("지갑 주소 입력", text: $viewModel.walletAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("잔액 조회") {
                // 버튼 클릭 시 async Task 내에서 fetchBalance() 호출
                Task {
                    await viewModel.fetchBalance()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            if !viewModel.balance.isEmpty {
                Text("잔액: \(viewModel.balance) ETH")
                    .font(.title2)
                    .padding()
            }
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
