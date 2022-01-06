import Foundation

func solution() -> Int{
    let N = Int(readLine()!)!
    let MOD = 1000000
    var dp = [[Int]](repeating: [Int](repeating: -1, count: 100), count: 100)
    func solve(_ left: Int, _ right: Int) -> Int{
        if left+right == 0 { return 1 }
        var ret = dp[left][right]
        if ret != -1 { return ret }
        
        ret = 0
        if right == 0 { return ret }
        for i in 0..<right{
            ret += solve(right-1-i, left+i)%MOD
        }
        ret %= MOD
        dp[left][right] = ret
        return ret
    }
    if N == 1 {
        return 1
    }
    var ans = 0
    for i in 0..<N{
        ans += solve(i, N-i-1)%MOD
        ans += solve(N-i-1, i)%MOD
    }
    return ans%MOD
}
print(solution())
