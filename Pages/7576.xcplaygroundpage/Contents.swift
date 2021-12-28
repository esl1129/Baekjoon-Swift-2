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
    let fIO = FileIO()
    let M = fIO.readInt()
    let N = fIO.readInt()
    var q = DoubleStackQueue<Point>()
    
    var board = [[Int]](repeating: [], count: N)
    for i in 0..<N{
        for j in 0..<M{
            let n = fIO.readInt()
            board[i].append(n)
            if n == 1 { q.enqueue(Point(i, j)) }
        }
    }
    while !q.isEmpty{
        let a = q.dequeue()
        for k in 0..<4{
            let xx = a.x+dx[k]
            let yy = a.y+dy[k]
            if !isBound(xx, yy) || board[xx][yy] != 0 { continue }
            board[xx][yy] = board[a.x][a.y]+1
            q.enqueue(Point(xx, yy))
        }
    }
    let a = board.flatMap{$0}
    if a.contains(0) { return -1 }
    return a.max()!-1
}

print(solution())
