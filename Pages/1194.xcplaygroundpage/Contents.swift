import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
struct Person: Hashable{
    let x: Int
    let y: Int
    let keys: Set<String>
    init(_ x: Int, _ y: Int, _ keys: Set<String>){
        self.x = x
        self.y = y
        self.keys = keys
    }
}

let upper: Set<String> = ["A","B","C","D","E","F"]
let lower: Set<String> = ["a","b","c","d","e","f"]

func solution() -> Int{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < ROW && yy < COL
    }
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let ROW = line[0]
    let COL = line[1]
    
    var board = [[String]]()
    var start: Person?
    for _ in 0..<ROW{
        board.append(readLine()!.map{String($0)})
    }
    for i in 0..<ROW{
        for j in 0..<COL{
            if board[i][j] == "0"{
                start = Person(i, j, [])
            }
        }
    }
    
    var visitedSet: Set<Person> = [start!]
    var q = [start]
    var answer = 1
    while !q.isEmpty{
        for _ in q.indices{
            let a = q.removeFirst()!
            for k in 0..<4{
                let xx = a.x+dx[k]
                let yy = a.y+dy[k]
                if !isBound(xx, yy) || board[xx][yy] == "#" { continue }
                if board[xx][yy] == "1" { return answer }
                if board[xx][yy] == "." || board[xx][yy] == "0"{
                    let p1 = Person(xx, yy, a.keys)
                    if visitedSet.contains(p1) { continue}
                    q.append(p1)
                    visitedSet.insert(p1)
                }else{
                    if lower.contains(board[xx][yy]){
                        let p1 = Person(xx, yy, a.keys.union([board[xx][yy]]))
                        if visitedSet.contains(p1) { continue }
                        q.append(p1)
                        visitedSet.insert(p1)
                    }else if upper.contains(board[xx][yy]){
                        if !a.keys.contains(board[xx][yy].lowercased()) { continue }
                        let p1 = Person(xx, yy, a.keys)
                        if visitedSet.contains(p1) { continue}
                        q.append(p1)
                        visitedSet.insert(p1)
                    }
                }
            }
        }
        answer += 1
    }
    return -1
}
print(solution())

