import Foundation

var board = [[String]]()
for _ in 0..<6{
    board.append(readLine()!.map{String($0)})
}

func DFS(_ depth: Int, _ arr: [Int]) -> String{
    if depth == 6{
        for i in 0..<3{
            for j in 0..<3{
                if board[arr[i]][j] != board[arr[j+3]][i] {
                    return ""
                }
            }
        }
        var strs = [String]()
        for k in 0..<3{
            strs.append(board[arr[k]].joined())
        }
        return strs.joined(separator: "\n")
    }
    var answer = ""
    for i in 0..<6{
        if !arr.contains(i){
            let now = DFS(depth+1, arr+[i])
            if now.isEmpty { continue }
            if answer.isEmpty{
                answer = now
                continue
            }
            answer = answer < now ? answer : now
        }
    }
    if answer.isEmpty{
        return ""
    }
    return answer
}

let a = DFS(0, [])
print(a.isEmpty ? "0" : a)

