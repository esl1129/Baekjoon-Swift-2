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
let N = Int(readLine()!)!
var board = [[Int]]()

for _ in 0..<N{
    board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
}

func solution(_ n: Int, _ board: [[Int]]) -> Int{
    var areaBrd = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    var edgeDict = [Int: Set<Point>]()
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < n && yy < n
    }
    func find(_ num: Int, _ p: Point) -> Int{
        var visitedSet = Set<Point>()
        visitedSet.insert(p)
        var q = [p]
        var cnt = 0
        while !q.isEmpty{
            for _ in q.indices{
                let a = q.removeFirst()
                for k in 0..<4{
                    let xx = a.x+dx[k]
                    let yy = a.y+dy[k]
                    if !isBound(xx, yy) { continue }
                    if areaBrd[xx][yy] != num && areaBrd[xx][yy] != 0 { return cnt }
                    let cp = Point(xx, yy)
                    if visitedSet.contains(cp) { continue }
                    visitedSet.insert(cp)
                    q.append(cp)
                }
            }
            cnt += 1
        }
        return Int.max
    }
    var area = 1
    for i in 0..<n{
        for j in 0..<n{
            if areaBrd[i][j] != 0 || board[i][j] == 0 { continue }
            areaBrd[i][j] = area
            var q = [Point(i, j)]
            while !q.isEmpty{
                let a = q.removeFirst()
                for k in 0..<4{
                    let xx = a.x+dx[k]
                    let yy = a.y+dy[k]
                    if !isBound(xx, yy) { continue }
                    if areaBrd[xx][yy] != 0 { continue }
                    if board[xx][yy] == 0 {
                        if edgeDict[area] == nil{
                            edgeDict[area] = [Point(a.x, a.y)]
                        }else{
                            edgeDict[area]!.insert(Point(a.x, a.y))
                        }
                        continue
                    }
                    q.append(Point(xx, yy))
                    areaBrd[xx][yy] = area
                }
            }
            area += 1
        }
    }
    
    var answer = Int.max
    for (num, points) in edgeDict{
        for p in points {
            let now = find(num, p)
            answer = answer < now ? answer : now
        }
    }

    return answer
}

print(solution(N, board))
