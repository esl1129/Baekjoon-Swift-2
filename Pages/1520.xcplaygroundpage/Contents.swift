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

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
func solution() -> Int{
    let fIO = FileIO()
    let R = fIO.readInt()
    let C = fIO.readInt()
    var brd = [[Int]](repeating: [], count: R)
    for i in 0..<R{
        for _ in 0..<C{
            brd[i].append(fIO.readInt())
        }
    }
    var dp = [[Int]](repeating: [Int](repeating: 0, count: C), count: R)
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: C), count: R)
    dp[0][0] = 1
    visited[R-1][C-1] = true
    
    func isBound(_ xx: Int, _ yy: Int) -> Bool{
        return xx >= 0 && yy >= 0 && xx < R && yy < C
    }
    func DFS(_ x:Int, _ y:Int){
        for k in 0..<4{
            let xx = x+dx[k]
            let yy = y+dy[k]
            if !isBound(xx, yy) || brd[xx][yy] <= brd[x][y]{
                continue
            }
            if !visited[xx][yy] {
                visited[xx][yy] = true
                DFS(xx, yy)
            }
            dp[x][y] += dp[xx][yy]
        }
    }
    DFS(R-1, C-1)
    return dp[R-1][C-1]
}

print(solution())

