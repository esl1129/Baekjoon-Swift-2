import Foundation
struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x:Int, _ y:Int){
        self.x = x
        self.y = y
    }
}

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
func solution() -> (cnt: Int, str: String){
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
    }
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[0]
    let COL = line[1]
    let K = line[2]

    var board = [[Int]](repeating: [Int](repeating: 0, count: COL), count: ROW)
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)

    for _ in 0..<K{
        let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
        for i in line[1]..<line[3]{
            for j in line[0]..<line[2]{
                if board[i][j] != 0 { continue }
                board[i][j] = 1
            }
        }
    }
    
    var total = 0
    var arr: [Int] = []
    for i in 0..<ROW{
        for j in 0..<COL{
            if board[i][j] != 0 || visited[i][j] { continue }
            total += 1
            var cnt = 1
            var q = [Point(i, j)]
            visited[i][j] = true
            while !q.isEmpty{
                let a = q.removeFirst()
                for k in 0..<4{
                    let xx = a.x+dx[k]
                    let yy = a.y+dy[k]
                    if !isBound(xx, yy) || visited[xx][yy] || board[xx][yy] != 0 { continue }
                    q.append(Point(xx, yy))
                    visited[xx][yy] = true
                    cnt += 1
                }
            }
            arr.append(cnt)
        }
    }
    return (total,arr.sorted().map{String($0)}.joined(separator: " "))
}

let answer = solution()
print(answer.cnt)
print(answer.str)
