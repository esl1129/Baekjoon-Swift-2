import Foundation

struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x:Int, _ y:Int){
        self.x = x
        self.y = y
    }
}
struct Count{
    let wolf: Int
    let sheep: Int
    init(_ wolf:Int, _ sheep:Int){
        self.wolf = wolf
        self.sheep = sheep
    }
    func getSheep() -> Int{
        return wolf >= sheep ? 0 : sheep
    }
    func getWolf() -> Int{
        return sheep > wolf ? 0 : wolf
    }
}
let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
func solution() -> String{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
    }
    var countArr = [Count]()
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[0]
    let COL = line[1]
    var board = [[String]]()
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    for _ in 0..<ROW{
        board.append(readLine()!.map{String($0)})
    }
    for i in 0..<ROW{
        for j in 0..<COL{
            if visited[i][j] || board[i][j] == "#" { continue }
            visited[i][j] = true
            var q = [Point(i, j)]
            var wolf = 0
            var sheep = 0
            if board[i][j] == "v" { wolf += 1}
            if board[i][j] == "o" { sheep += 1}
            while !q.isEmpty{
                let a = q.removeFirst()
                for k in 0..<4{
                    let xx = a.x+dx[k]
                    let yy = a.y+dy[k]
                    if !isBound(xx, yy) || visited[xx][yy] || board[xx][yy] == "#" { continue }
                    if board[xx][yy] == "v" { wolf += 1 }
                    if board[xx][yy] == "o" { sheep += 1 }
                    q.append(Point(xx, yy))
                    visited[xx][yy] = true
                }
            }
            countArr.append(Count(wolf, sheep))
        }
    }
    var wolf = 0
    var sheep = 0
    for cnt in countArr{
        wolf += cnt.getWolf()
        sheep += cnt.getSheep()
    }
    return "\(sheep) \(wolf)"
}

print(solution())
