import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int,_ y: Int){
        self.x = x
        self.y = y
    }
}


func solution() -> Int{
    func DFS(_ yCnt: Int, _ sCnt: Int, _ set: Set<Point>){
        if yCnt+sCnt >= 7 {
            if sCnt > 3{
                answerSet.insert(set)
            }
            return
        }
        for p in set{
            for k in 0..<4{
                let xx = p.x+dx[k]
                let yy = p.y+dy[k]
                if !isBound(xx, yy) { continue }
                let p1 = Point(xx, yy)
                if set.contains(p1) { continue }
                let newYCnt = board[xx][yy] == "Y" ? yCnt+1 : yCnt
                let newSCnt = board[xx][yy] == "S" ? sCnt+1 : sCnt
                DFS(newYCnt, newSCnt, set.union([p1]))
            }
        }
        return
    }
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < 5 && yy < 5
    }
    var answerSet = Set<Set<Point>>()
    var board = [[String]]()
    for _ in 0..<5{
        board.append(readLine()!.map{String($0)})
    }
    for i in 0..<5{
        for j in 0..<5{
            let yCnt = board[i][j] == "Y" ? 1 : 0
            let sCnt = board[i][j] == "S" ? 1 : 0
            DFS(yCnt, sCnt, [Point(i, j)])
        }
    }
    return answerSet.count
}

print(solution())
