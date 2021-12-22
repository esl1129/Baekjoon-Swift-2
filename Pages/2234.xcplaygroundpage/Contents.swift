import Foundation

let dx = [0,-1,0,1]
let dy = [-1,0,1,0]
struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x:Int, _ y:Int){
        self.x = x
        self.y = y
    }
}

func solution() -> (cnt: Int, maxVolume: Int, max2Volume: Int){
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
    }
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[1]
    let COL = line[0]

    var board = [[Int]]()
    var newBoard = [[[Bool]]](repeating: [], count: ROW)
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: COL), count: ROW)
    for _ in 0..<ROW{
        board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    }

    for i in 0..<ROW{
        for j in 0..<COL{
            let num = board[i][j]
            newBoard[i].append([num%2 == 1, (num%4)/2 == 1, (num%8)/4 == 1,num/8 == 1])
        }
    }
    
    var q: [Point] = []
    var cnt = 0
    var max = 0
    var max2 = 0
    for i in 0..<ROW{
        for j in 0..<COL{
            if visited[i][j] { continue }
            var vol = 1
            visited[i][j] = true
            q = [Point(i, j)]
            while !q.isEmpty{
                let a = q.removeFirst()
                for k in 0..<4{
                    if newBoard[a.x][a.y][k] { continue }
                    let xx = a.x+dx[k]
                    let yy = a.y+dy[k]
                    if !isBound(xx, yy) || visited[xx][yy] { continue }
                    visited[xx][yy] = true
                    q.append(Point(xx, yy))
                    vol += 1
                }
            }
            max = max > vol ? max : vol
            cnt += 1
        }
    }
    
    for i in 0..<ROW{
        for j in 0..<COL{
            for k in 0..<4{
                if !newBoard[i][j][k] { continue }
                let start = Point(i, j)
                var visitedSet: Set<Point> = [start]
                newBoard[i][j][k] = false
                q = [start]
                while !q.isEmpty{
                    let a = q.removeFirst()
                    for k in 0..<4{
                        if newBoard[a.x][a.y][k] { continue }
                        let xx = a.x+dx[k]
                        let yy = a.y+dy[k]
                        if !isBound(xx, yy) { continue }
                        let now = Point(xx, yy)
                        if visitedSet.contains(now) { continue }
                        visitedSet.insert(now)
                        q.append(now)
                    }
                }
                max2 = max2 > visitedSet.count ? max2 : visitedSet.count
                newBoard[i][j][k] = true
            }
        }
    }
    return (cnt, max, max2)
}

let answer = solution()
print(answer.cnt)
print(answer.maxVolume)
print(answer.max2Volume)
