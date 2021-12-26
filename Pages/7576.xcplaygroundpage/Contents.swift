import Foundation

struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x:Int, _ y:Int){
        self.x = x
        self.y = y
    }
}

let dx = [-1,0,1,0]
let dy = [0,-1,0,1]

func solution() -> Int{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < N && yy < M
    }
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let N = line[1]
    let M = line[0]
    
    var board = [[Int]]()
        for _ in 0..<N{
            board.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
        
    }
    var q = [Point]()
    var zeroCnt = 0
        for i in 0..<N{
            for j in 0..<M{
                if board[i][j] == 0 { zeroCnt += 1 }
                if board[i][j] == 1 { q.append(Point(i, j)) }
            }
        }
    
    if zeroCnt == 0 { return 0 }
    var answer = 1
    while !q.isEmpty{
        for _ in q.indices{
            let a = q.removeFirst()
            for k in 0..<4{
                let xx = a.x+dx[k]
                let yy = a.y+dy[k]
                if !isBound(xx, yy) || board[xx][yy] != 0 { continue }
                zeroCnt -= 1
                if zeroCnt == 0 { return answer}
                board[xx][yy] = 1
                q.append(Point(xx, yy))
            }
        }
        answer += 1
    }
    return -1
}

print(solution())
