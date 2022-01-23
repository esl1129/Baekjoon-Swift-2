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

struct Point{
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}
func solution() -> Int{
    func check() -> Bool {
        var cnt = 0
        var rowCnt = 0
        var colCnt = 0
        for i in 0..<5{
            for j in 0..<5{
                if visited[i][j] { rowCnt += 1 }
                if visited[j][i] { colCnt += 1 }
            }
            if rowCnt == 5 { cnt += 1}
            if colCnt == 5 { cnt += 1}
            rowCnt = 0
            colCnt = 0
        }
        for k in 0..<5{
            if visited[k][k] { rowCnt += 1}
            if visited[4-k][k] { colCnt += 1 }
        }
        if rowCnt == 5 { cnt += 1}
        if colCnt == 5 { cnt += 1}
        return cnt >= 3 ? true : false
    }
    let fIO = FileIO()
    var pointArr = [Point](repeating: Point(0, 0), count: 26)
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: 5), count: 5)
    for i in 0..<5{
        for j in 0..<5{
            let num = fIO.readInt()
            pointArr[num] = Point(i, j)
        }
    }
    for i in 1...25{
        let idx = fIO.readInt()
        let xx = pointArr[idx].x
        let yy = pointArr[idx].y
        visited[xx][yy] = true
        if check() {
            return i
        }
    }
    return 25
}

print(solution())
