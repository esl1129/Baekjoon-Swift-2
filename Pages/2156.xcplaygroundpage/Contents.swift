import Foundation

let N = Int(readLine()!)!
var wine = [0]

for _ in 0..<N{
    wine.append(Int(readLine()!)!)
}

func solution(_ n: Int, _ wine: [Int]) -> Int{
    if n < 2{
        return wine[n]
    }
    var dp = [0,wine[1],wine[1]+wine[2]]
    if n < 3{
        return dp[n]
    }
    for i in 3...n{
        dp.append([dp[i-3]+wine[i-1]+wine[i],dp[i-2]+wine[i],dp[i-1]].max()!)
    }
    return dp.last!
}

print(solution(N, wine))
