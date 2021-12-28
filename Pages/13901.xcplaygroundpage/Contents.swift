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
struct Point: Hashable{
    var x: Int
    var y: Int
    init(_ x: Int,_ y: Int){
        self.x = x
        self.y = y
    }
}
let dx = [0,-1,1,0,0]
let dy = [0,0,0,-1,1]
func solution() -> String{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < N && yy < M
    }
    let fIO = FileIO()
    let N = fIO.readInt()
    let M = fIO.readInt()
    var board = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    let K = fIO.readInt()
    for _ in 0..<K{
        board[fIO.readInt()][fIO.readInt()] = 1
    }
    var s = Point(fIO.readInt(), fIO.readInt())
    var dirSet = [fIO.readInt(),fIO.readInt(),fIO.readInt(),fIO.readInt()]
    
    while true{
        var check = true
        for _ in 1...4{
            let dir = dirSet.first!
            let xx = s.x+dx[dir]
            let yy = s.y+dy[dir]
            if !isBound(xx, yy) || board[xx][yy] == 1 {
                dirSet.append(dirSet.removeFirst())
                continue
            }
            board[s.x][s.y] = 1
            check = false
            s.x = xx
            s.y = yy
            break
        }
        if check{
            return "\(s.x) \(s.y)"
        }
    }
}

print(solution())
