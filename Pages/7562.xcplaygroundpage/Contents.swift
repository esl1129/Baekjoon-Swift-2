import Foundation

struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x:Int, _ y:Int){
        self.x = x
        self.y = y
    }
}

let dx = [-2,-1,1,2,2,1,-1,-2]
let dy = [1,2,2,1,-1,-2,-2,-1]

func solution() -> Int{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < l && yy < l
    }
    let l = Int(readLine()!)!
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: l), count: l)
    let sl = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    visited[sl[0]][sl[1]] = true
    let end = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    var q = [Point(sl[0], sl[1])]
    var answer = 1
    while !q.isEmpty{
        for _ in q.indices{
            let a = q.removeFirst()
            for k in 0..<8{
                let xx = a.x+dx[k]
                let yy = a.y+dy[k]
                if !isBound(xx, yy) || visited[xx][yy] { continue }
                if end[0] == xx && end[1] == yy { return answer }
                q.append(Point(xx, yy))
                visited[xx][yy] = true
            }
        }
        answer += 1
    }
    return 0
}

let TC = Int(readLine()!)!

for _ in 0..<TC{
    print(solution())
}
