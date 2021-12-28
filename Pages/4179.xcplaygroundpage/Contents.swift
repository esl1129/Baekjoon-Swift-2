import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
struct DoubleStackQueue<Element> {
    private var inbox: [Element] = []
    private var outbox: [Element] = []
    
    var isEmpty: Bool{
        return inbox.isEmpty && outbox.isEmpty
    }
    
    var count: Int{
        return inbox.count + outbox.count
    }
    
    var front: Element? {
        return outbox.last ?? inbox.first
    }
    
    init() { }
    
    init(_ array: [Element]) {
        self.init()
        self.inbox = array
    }
    
    mutating func enqueue(_ n: Element) {
        inbox.append(n)
    }
    
    mutating func dequeue() -> Element {
        if outbox.isEmpty {
            outbox = inbox.reversed()
            inbox.removeAll()
        }
        return outbox.removeLast()
    }
}

extension DoubleStackQueue: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init()
        inbox = elements
    }
}
struct Point: Hashable{
    let x: Int
    let y: Int
    init(_ x: Int,_ y: Int){
        self.x = x
        self.y = y
    }
}
func solution() -> String{
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
    var jq = DoubleStackQueue<Point>()
    var fq = DoubleStackQueue<Point>()
    
    for i in 0..<ROW{
        for j in 0..<COL{
            if board[i][j] == "J"{
                jq.enqueue(Point(i, j))
            }
            if board[i][j] == "F"{
                fq.enqueue(Point(i, j))
            }
        }
    }
    var answer = 1
    while !jq.isEmpty{
        for _ in 0..<fq.count{
            let f = fq.dequeue()
            for k in 0..<4{
                let xx = f.x+dx[k]
                let yy = f.y+dy[k]
                if !isBound(xx, yy) || board[xx][yy] == "F" || board[xx][yy] == "#"{ continue }
                board[xx][yy] = "F"
                fq.enqueue(Point(xx, yy))
            }
        }
        for _ in 0..<jq.count{
            let j = jq.dequeue()
            for k in 0..<4{
                let xx = j.x+dx[k]
                let yy = j.y+dy[k]
                if !isBound(xx, yy) { return String(answer) }
                if board[xx][yy] != "." { continue }
                board[xx][yy] = "J"
                jq.enqueue(Point(xx, yy))
            }
        }
        
        answer += 1
    }
    return "IMPOSSIBLE"
}

print(solution())
