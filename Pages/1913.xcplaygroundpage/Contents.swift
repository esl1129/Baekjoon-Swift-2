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

let fIO = FileIO()

let dx = [1,0,-1,0]
let dy = [0,1,0,-1]

struct Point{
    let x: Int
    let y: Int
    init (_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}
func solution() -> String{
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < N && yy < N
    }
    let N = fIO.readInt()
    let F = fIO.readInt()
    
    var ans = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    var ansStr = ""
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    var start = Point(0, 0)
    var cnt = N*N
    var dir = 0
    while cnt > 0 {
        ans[start.x][start.y] = cnt
        if cnt == F {
            ansStr = "\(start.x+1) \(start.y+1)"
        }
        visited[start.x][start.y] = true
        cnt -= 1
        var xx = start.x+dx[dir]
        var yy = start.y+dy[dir]
        if !isBound(xx, yy) || visited[xx][yy] {
            dir = dir == 3 ? 0 : dir+1
            xx = start.x+dx[dir]
            yy = start.y+dy[dir]
        }
        start = Point(xx, yy)
    }
    for a in ans {
        print(a.map{String($0)}.joined(separator: " "))
    }
    return ansStr
}

print(solution())
