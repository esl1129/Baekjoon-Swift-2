import Foundation

func solution() -> Int{
    var max = 0
    func getCandy(_ board: [[String]]) -> Int{
        var ans = 1
        for i in 0..<N{
            var now = 1
            var s = board[i][0]
            for j in 1..<N{
                if board[i][j] != s {
                    ans = ans > now ? ans : now
                    now = 1
                    s = board[i][j]
                    continue
                }
                now += 1
            }
            ans = ans > now ? ans : now
        }
        for i in 0..<N{
            var now = 1
            var s = board[0][i]
            for j in 1..<N{
                if board[j][i] != s {
                    ans = ans > now ? ans : now
                    now = 1
                    s = board[j][i]
                    continue
                }
                now += 1
            }
            ans = ans > now ? ans : now
        }
        return ans
    }
    let N = Int(readLine()!)!
    var board = [[String]]()
    for _ in 0..<N{
        board.append(readLine()!.map{String($0)})
    }
    
    for i in 1..<N{
        for j in 1..<N{
            var newBrd1 = board
            newBrd1[i-1][j] = board[i][j]
            newBrd1[i][j] = board[i-1][j]
            let now1 = getCandy(newBrd1)
            max = max > now1 ? max : now1
            var newBrd2 = board
            newBrd2[i][j-1] = board[i][j]
            newBrd2[i][j] = board[i][j-1]
            let now2 = getCandy(newBrd2)
            max = max > now2 ? max : now2
        }
    }
    return max
}

print(solution())
