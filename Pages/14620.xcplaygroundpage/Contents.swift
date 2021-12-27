import Foundation

struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int){
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
    var pSet = Set<Set<Point>>()
    func findPoints(_ startX: Int, _ startY: Int, _ set: Set<Point>, _ visited: [[Bool]]){
        if set.count == 3{
            pSet.insert(set)
            return
        }
        for i in startX..<N-1{
            for j in 1..<N-1{
                if startX == i && j < startY { continue }
                var check = true
                for k in 0..<4{
                    let xx = i+dx[k]
                    let yy = j+dy[k]
                    if visited[xx][yy] {
                        check = false
                        break
                    }
                }
                if check{
                    var newVisit = visited
                    newVisit[i][j] = true
                    for k in 0..<4{
                        newVisit[i+dx[k]][j+dy[k]] = true
                    }
                    findPoints(i, j, set.union([Point(i, j)]), newVisit)
                }
            }
        }
        return
    }
    
    let N = Int(readLine()!)!
    var board = [[Int]]()
    for _ in 0..<N{
        board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    }
    let visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    findPoints(1, 1, [], visited)
    var answer = Int.max
    for ps in pSet{
        var now = 0
        for p in ps{
            now += board[p.x][p.y]
            for k in 0..<4{
                now += board[p.x+dx[k]][p.y+dy[k]]
            }
        }
        answer = answer < now ? answer : now
    }
    return answer
}

print(solution())
