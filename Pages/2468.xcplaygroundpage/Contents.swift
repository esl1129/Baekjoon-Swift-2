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
        return xx >= 0 && yy >= 0 && xx < N && yy < N
    }
    func BFS(_ depth: Int) -> Int{
        var now = 0
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
        for i in 0..<N{
            for j in 0..<N{
                if board[i][j] < depth || visited[i][j] { continue }
                now += 1
                var q = [Point(i, j)]
                visited[i][j] = true
                while !q.isEmpty{
                    let a = q.removeFirst()
                    for k in 0..<4{
                        let xx = a.x+dx[k]
                        let yy = a.y+dy[k]
                        if !isBound(xx, yy) || visited[xx][yy] || board[xx][yy] < depth { continue }
                        visited[xx][yy] = true
                        q.append(Point(xx, yy))
                    }
                }
            }
        }
        return now
    }
    let N = Int(readLine()!)!
    var board = [[Int]]()
    for _ in 0..<N{
        board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    }
    var depth = 1
    var max = 0
    var now = 1
    while now > 0{
        now = BFS(depth)
        depth += 1
        max = max > now ? max : now
    }
    return max
}

print(solution())
