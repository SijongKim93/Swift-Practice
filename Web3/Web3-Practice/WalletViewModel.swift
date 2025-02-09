import Foundation
import web3swift
import BigInt

@MainActor
class WalletViewModel: ObservableObject {
    @Published var walletAddress: String = ""
    @Published var balance: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    func fetchBalance() async {
        // 초기화
        self.balance = ""
        self.errorMessage = ""
        self.isLoading = true
        
        // 지갑 주소 입력이 없으면 종료
        guard !walletAddress.isEmpty else {
            self.errorMessage = "지갑 주소를 입력하세요."
            self.isLoading = false
            return
        }
        
        // 주소 유효성 검증: 현재 web3swift에서 EthereumAddress 생성자가 failable하지 않다면
        let ethAddress = EthereumAddress(walletAddress)
        
        // Infura URL 생성 – 반드시 YOUR_PROJECT_ID를 본인의 Infura 프로젝트 ID로 교체
        guard let infuraUrl = URL(string: "https://mainnet.infura.io/v3/YOUR_PROJECT_ID") else {
            self.errorMessage = "Infura URL 오류"
            self.isLoading = false
            return
        }
        
        // Web3HttpProvider를 이용한 프로바이더 생성
        guard let provider = await Web3HttpProvider(infuraUrl, network: .Mainnet) else {
            self.errorMessage = "프로바이더 생성 실패"
            self.isLoading = false
            return
        }
        
        // Web3 인스턴스 생성
        let web3 = Web3(provider: provider)
        
        do {
            // 기존 동기식 getBalance를 async/await로 감싸기
            let balanceResult: BigUInt = try await withCheckedThrowingContinuation { continuation in
                DispatchQueue.global().async {
                    do {
                        let result = try web3.eth.getBalance(for: ethAddress)
                        continuation.resume(returning: result)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            // 잔액을 ETH 단위로 포맷 (소수점 4자리)
            let formattedBalance = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 4) ?? "0"
            self.balance = formattedBalance
        } catch {
            self.errorMessage = "잔액 조회 실패: \(error.localizedDescription)"
        }
        self.isLoading = false
    }
}
