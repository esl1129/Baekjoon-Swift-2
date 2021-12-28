import Foundation

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
    let z: Int
    init(_ x:Int, _ y:Int,_ z: Int){
        self.x = x
        self.y = y
        self.z = z
    }
}

let dx = [-1,0,1,0,0,0]
let dy = [0,-1,0,1,0,0]
let dz = [0,0,0,0,-1,1]

func solution() -> Int{
    func isBound(_ xx: Int, _ yy: Int, _ zz: Int) -> Bool{
        return xx >= 0 && yy >= 0 && zz >= 0 && xx < N && yy < M && zz < H
    }
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let N = line[1]
    let M = line[0]
    let H = line[2]
    
    var board = [[[Int]]](repeating: [], count: H)
    for h in 0..<H{
        for _ in 0..<N{
            board[h].append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
        }
    }
    var q = DoubleStackQueue<Point>()
    var zeroCnt = 0
    for h in 0..<H{
        for i in 0..<N{
            for j in 0..<M{
                if board[h][i][j] == 0 { zeroCnt += 1 }
                if board[h][i][j] == 1 { q.enqueue(Point(i, j, h)) }
            }
        }
    }
    if zeroCnt == 0 { return 0 }
    var answer = 1
    while !q.isEmpty{
        for _ in 0..<q.count{
            let a = q.dequeue()
            for k in 0..<6{
                let xx = a.x+dx[k]
                let yy = a.y+dy[k]
                let zz = a.z+dz[k]
                if !isBound(xx, yy, zz) || board[zz][xx][yy] != 0 { continue }
                zeroCnt -= 1
                if zeroCnt == 0 { return answer }
                board[zz][xx][yy] = 1
                q.enqueue(Point(xx, yy, zz))
            }
        }
        answer += 1
    }
    return -1
}

print(solution())
