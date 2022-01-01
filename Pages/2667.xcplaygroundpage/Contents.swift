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
}
func solution() -> String{
    let dx = [1,0,-1,0]
    let dy = [0,1,0,-1]
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < N && yy < N
    }
    let fIO = FileIO()
    let N = fIO.readInt()
    var board = [[String]]()
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    
    var answer = 0
    var answerArr: [Int] = []
    for _ in 0..<N{
        board.append(fIO.readString().map{String($0)})
    }
    for i in 0..<N{
        for j in 0..<N{
            if board[i][j] == "0" || visited[i][j] { continue }
            visited[i][j] = true
            answer += 1
            var cnt = 1
            var q = DoubleStackQueue<Point>()
            q.enqueue(Point(x: i, y: j))
            while !q.isEmpty{
                let a = q.dequeue()
                for k in 0..<4{
                    let xx = a.x+dx[k]
                    let yy = a.y+dy[k]
                    if !isBound(xx, yy) || visited[xx][yy] || board[xx][yy] != "1" { continue }
                    q.enqueue(Point(x: xx, y: yy))
                    visited[xx][yy] = true
                    cnt += 1
                }
            }
            answerArr.append(cnt)
        }
    }
    return "\(answer)\n"+answerArr.sorted().map{String($0)}.joined(separator: "\n")
}
print(solution())
