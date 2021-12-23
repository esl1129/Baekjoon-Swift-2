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
func solution() -> Int{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
    }
    func BFS(_ p: Point) -> Int{
        var visited = sampleVisit
        visited[p.x][p.y] = true
        var q = [p]
        var cnt = 0
        while !q.isEmpty{
            for _ in q.indices{
                let a = q.removeFirst()
                for k in 0..<4{
                    let xx = a.x+dx[k]
                    let yy = a.y+dy[k]
                    if !isBound(xx, yy) || visited[xx][yy] || board[xx][yy] == "W" { continue }
                    visited[xx][yy] = true
                    q.append(Point(xx, yy))
                }
            }
            cnt += 1
        }
        return cnt-1
    }
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[0]
    let COL = line[1]
    var board = [[String]]()
    let sampleVisit = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)

    for _ in 0..<ROW{
        board.append(readLine()!.map{String($0)})
    }
    
    var max = 0
    for i in 0..<ROW{
        for j in 0..<COL{
            if board[i][j] == "W" { continue }
            let now = BFS(Point(i, j))
            max = max > now ? max : now
        }
    }
    
    return max
}

print(solution())
