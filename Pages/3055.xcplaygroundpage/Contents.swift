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
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[0]
    let COL = line[1]
    var board = [[String]]()

    for _ in 0..<ROW{
        board.append(readLine()!.map{String($0)})
    }
    var waterArr = [Point]()
    var start = Point(0,0)
    for i in 0..<ROW{
        for j in 0..<COL{
            if board[i][j] == "S" { start = Point(i, j)}
            if board[i][j] == "*" { waterArr.append(Point(i, j))}
        }
    }
    var answer = 1
    var q = [start]
    while !q.isEmpty{
        for _ in waterArr.indices{
            let w = waterArr.removeFirst()
            for k in 0..<4{
                let xx = w.x+dx[k]
                let yy = w.y+dy[k]
                if !isBound(xx, yy) || board[xx][yy] == "D" || board[xx][yy] == "*" || board[xx][yy] == "X" { continue }
                board[xx][yy] = "*"
                waterArr.append(Point(xx, yy))
            }
        }
        for _ in q.indices{
            let s = q.removeFirst()
            for k in 0..<4{
                let xx = s.x+dx[k]
                let yy = s.y+dy[k]
                if !isBound(xx, yy) { continue }
                if board[xx][yy] == "D" { return answer }
                if board[xx][yy] != "." { continue }
                board[xx][yy] = "S"
                q.append(Point(xx, yy))
            }
        }
        answer += 1
    }
    return -1
}
let a = solution()
print(a == -1 ? "KAKTUS" : a)
