import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
struct Point: Hashable{
    let x: Int
    let y: Int
    let dr: Int
    init(_ x: Int,_ y: Int,_ dr: Int){
        self.x = x
        self.y = y
        self.dr = dr
    }
}
func solution() -> Int{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
    }
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[0]
    let COL = line[1]
    var board = [[Int]]()
    for _ in 0..<ROW{
        board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    }
    var visited = Set<Point>()
    var sl = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    sl[2] = sl[2] == 1 ? 0 : sl[2] == 2 ? 2 : sl[2] == 3 ? 1 : 3
    let start = Point(sl[0]-1, sl[1]-1, sl[2])
    
    var el = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    el[2] = el[2] == 1 ? 0 : el[2] == 2 ? 2 : el[2] == 3 ? 1 : 3
    let end = Point(el[0]-1, el[1]-1, el[2])
    visited.insert(start)
    if start == end { return 0 }
    var q = [start]
    var ans = 1
    while !q.isEmpty{
        for _ in q.indices{
            let a = q.removeFirst()
            let pl = Point(a.x, a.y, a.dr == 0 ? 3 : a.dr-1)
            let pr = Point(a.x, a.y, a.dr == 3 ? 0 : a.dr+1)
            if pl == end || pr == end{ return ans }
            if !visited.contains(pl){
                visited.insert(pl)
                q.append(pl)
            }
            if !visited.contains(pr){
                visited.insert(pr)
                q.append(pr)
            }
            for k in 1...3{
                let xx = a.x+dx[a.dr]*k
                let yy = a.y+dy[a.dr]*k
                if !isBound(xx, yy) || board[xx][yy] == 1 { break }
                let p = Point(xx, yy, a.dr)
                if p == end { return ans}
                if visited.contains(p) { continue }
                q.append(p)
                visited.insert(p)
            }
        }
        ans += 1
    }
    return 1
}

print(solution())
