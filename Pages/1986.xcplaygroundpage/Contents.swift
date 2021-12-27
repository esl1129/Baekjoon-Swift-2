import Foundation

let dx = [0,1,1,1,0,-1,-1,-1]
let dy = [1,1,0,-1,-1,-1,0,1]
let kx = [1,2,2,1,-1,-2,-2,-1]
let ky = [2,1,-1,-2,-2,-1,1,2]
struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int,_ y: Int){
        self.x = x
        self.y = y
    }
}
func solution() -> Int{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
    }
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[0]
    let COL = line[1]
    
    var ql = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    var kl = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    var pl = readLine()!.components(separatedBy: " ").map{Int(String($0))!}

    let qCnt = ql.removeFirst()
    let kCnt = kl.removeFirst()
    let pCnt = pl.removeFirst()
    
    var qSet = Set<Point>()
    var kSet = Set<Point>()

    var visited = [[Int]](repeating: [Int](repeating: 0, count: COL), count: ROW)

    if qCnt != 0{
        for _ in 0..<qCnt{
            let y = ql.removeLast()-1
            let x = ql.removeLast()-1
            qSet.insert(Point(x, y))
            visited[x][y] = 1
        }
    }
    if kCnt != 0{
        for _ in 0..<kCnt{
            let y = kl.removeLast()-1
            let x = kl.removeLast()-1
            kSet.insert(Point(x, y))
            visited[x][y] = 1
        }
    }
    if pCnt != 0{
        for _ in 0..<pCnt{
            let y = pl.removeLast()-1
            let x = pl.removeLast()-1
            visited[x][y] = 1
        }
    }
    
    for q in qSet {
        for k in 0..<8{
            var xx = q.x+dx[k]
            var yy = q.y+dy[k]
            while isBound(xx, yy) && visited[xx][yy] != 1{
                visited[xx][yy] = -1
                xx += dx[k]
                yy += dy[k]
            }
        }
    }
    for n in kSet {
        for k in 0..<8{
            let xx = n.x+kx[k]
            let yy = n.y+ky[k]
            if !isBound(xx, yy) || visited[xx][yy] == 1 { continue }
            visited[xx][yy] = -1
        }
    }
    return visited.flatMap{$0}.filter{$0 == 0}.count
}

print(solution())
