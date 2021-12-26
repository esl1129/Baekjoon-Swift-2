import Foundation


func Solution() -> Int{
    var answer = 0
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let N = line[0]
    let K = line[1]
    var visited = [Int](repeating: 0, count: N+1)
    var board = [[Int]]()
    for i in 1...N{
        visited[i] = i
    }
    for _ in 0..<K{
        board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    }
    for b in board {
        if visited[b[0]] == visited[b[1]] { continue }
        answer += 1
        let min = visited[b[0]] < visited[b[1]] ? visited[b[0]] : visited[b[1]]
        let max = visited[b[0]] > visited[b[1]] ? visited[b[0]] : visited[b[1]]
        var oneCnt = 0
        for k in 1...N{
            if visited[k] == max { visited[k] = min }
            if visited[k] == 1 { oneCnt += 1}
        }
        if oneCnt == N { return answer}
    }
    return answer
}


let TC = Int(readLine()!)!
for _ in 0..<TC{
    print(Solution())
}
