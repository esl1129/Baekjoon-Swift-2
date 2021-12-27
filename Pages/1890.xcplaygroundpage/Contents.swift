import Foundation

func solution() -> Int{
    let N = Int(readLine()!)!
    var board = [[Int]]()
    for _ in 0..<N{
        board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    }
    var dp = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    if board[0][0] >= N {
        return 0
    }
    dp[0][0] = 1
    for i in 0..<N{
        for j in 0..<N{
            if dp[i][j] == 0 { continue }
            if i == N-1 && j == N-1 { break }
            if i+board[i][j] < N{
                dp[i+board[i][j]][j] += dp[i][j]
            }
            if j+board[i][j] < N{
                dp[i][j+board[i][j]] += dp[i][j]
            }
        }
    }
    return dp[N-1][N-1]
}

print(solution())
