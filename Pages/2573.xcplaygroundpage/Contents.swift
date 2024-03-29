import Foundation
final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}
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

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
func solution() -> Int{
    func BFS(_ p: Point) -> Int{
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)
        visited[p.x][p.y] = true
        var q = DoubleStackQueue<Point>()
        q.enqueue(p)
        var cnt = 1
        while !q.isEmpty{
            let a = q.dequeue()
            for k in 0..<4{
                let xx = a.x+dx[k]
                let yy = a.y+dy[k]
                if board[xx][yy] == 0 || visited[xx][yy]{ continue }
                cnt += 1
                visited[xx][yy] = true
                q.enqueue(Point(xx, yy))
            }
        }
        return cnt
    }
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < N && yy < M
    }
    var q = DoubleStackQueue<Point>()
    let fIO = FileIO()
    let N = fIO.readInt()
    let M = fIO.readInt()
    var board = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    for i in 0..<N{
        for j in 0..<M{
            let n = fIO.readInt()
            if n == 0 { continue }
            board[i][j] = n
            q.enqueue(Point(i, j))
        }
    }
    var depth = 0
    while !q.isEmpty{
        let n = BFS(q.front!)
        if n != q.count{
            return depth
        }
        var newBoard = board
        for _ in 0..<q.count{
            let a = q.dequeue()
            var cnt = 0
            for k in 0..<4{
                let xx = a.x+dx[k]
                let yy = a.y+dy[k]
                if board[xx][yy] == 0 { cnt += 1 }
            }
            if board[a.x][a.y] <= cnt {
                newBoard[a.x][a.y] = 0
            }else{
                newBoard[a.x][a.y] = board[a.x][a.y]-cnt
                q.enqueue(a)
            }
        }
        board = newBoard
        depth += 1
    }
    
    return 0
}

print(solution())
