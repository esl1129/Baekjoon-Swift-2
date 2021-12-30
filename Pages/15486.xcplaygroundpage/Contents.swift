import Foundation
// import FILEIO
func solution() -> Int{
    let fIO = FileIO()
    let N = fIO.readInt()
    var dp = [Int](repeating: 0, count: N+1)
    for i in 0..<N{
        let d = fIO.readInt()
        let p = fIO.readInt()
        if i+d <= N { dp[i+d] = dp[i+d] > dp[i]+p ? dp[i+d] : dp[i]+p }
        dp[i+1] = dp[i+1] > dp[i] ? dp[i+1] : dp[i]
    }
    return dp[N]
}
print(solution())
