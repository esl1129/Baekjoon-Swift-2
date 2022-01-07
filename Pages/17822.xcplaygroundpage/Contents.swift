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

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
func solution() -> Int{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx > 0 && yy >= 0 && xx <= N && yy < M
    }
    func replace(_ i: Int){
        for j in 0..<M{
            if board[i][j] == 0 { continue }
            var cnt = 1
            for k in 0..<4{
                var xx = i+dx[k]
                var yy = j+dy[k]
                if !isBound(xx, yy) {
                    if k%2 == 1 { continue }
                    xx -= dx[k]*N
                    yy -= dy[k]*M
                }
                if board[xx][yy] == board[i][j] { cnt += 1}
            }
            if cnt > 1 {
                newBoard[i][j] = 0
                for k in 0..<4{
                    var xx = i+dx[k]
                    var yy = j+dy[k]
                    if !isBound(xx, yy) {
                        if k%2 == 1 { continue }
                        xx -= dx[k]*N
                        yy -= dy[k]*M
                    }
                    if board[xx][yy] == board[i][j] {
                        newBoard[xx][yy] = 0
                    }
                }
            }
        }
        
    }
    let fIO = FileIO()
    let N = fIO.readInt()
    let M = fIO.readInt()
    let T = fIO.readInt()
    
    var board = [[Int]](repeating: [], count: N+1)
    board[0] = [Int](repeating: 0, count: M)
    var newBoard = board
    for i in 1...N{
        for _ in 0..<M{
            board[i].append(fIO.readInt())
        }
    }
    
    for t in 0..<T{
        let r = fIO.readInt()
        let dir = fIO.readInt()
        var k = fIO.readInt()
        k = dir == 0 ? M-k : k
        for i in 1..<N{
            let c = r*i
            if c > N { break }
            let prefix = board[c].prefix(k)
            let suffix = board[c].suffix(M-k)
            board[c] = Array(suffix+prefix)
        }
        newBoard = board
        for i in 1...N{
            if t == 0{
                replace(i)
            }else{
                let c = r*i
                if c > N { break }
                replace(c)
            }
        }
        board = newBoard
    }
    return board.flatMap{$0}.reduce(0, +)
}

print(solution())
