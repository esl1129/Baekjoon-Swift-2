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

func solution() -> Int{
    let N = fIO.readInt()
    var arr = [[Int]](repeating: [Int](repeating: 0, count: N), count: 2)
    for r in 0..<2{
        for c in 0..<N{
            arr[r][c] = fIO.readInt()
        }
    }
    if N == 1 {
        return arr[0][0] > arr[1][0] ? arr[0][0] : arr[1][0]
    }
    if N == 2 {
        return arr[0][0]+arr[1][1] > arr[1][0]+arr[0][1] ? arr[0][0]+arr[1][1] : arr[1][0]+arr[0][1]
    }
    
    var dp = [[Int]](repeating: [Int](repeating: 0, count: N), count: 2)
    dp[0][0] = arr[0][0]
    dp[1][0] = arr[1][0]
    dp[0][1] = arr[0][1]+arr[1][0]
    dp[1][1] = arr[1][1]+arr[0][0]
    
    for i in 2..<N{
        dp[0][i] = [dp[1][i-1],dp[0][i-2],dp[1][i-2]].max()!+arr[0][i]
        dp[1][i] = [dp[0][i-1],dp[0][i-2],dp[1][i-2]].max()!+arr[1][i]
    }
    
    return [dp[0][N-2],dp[0][N-1],dp[1][N-2],dp[1][N-1]].max()!
}

let TC = fIO.readInt()
for _ in 0..<TC{
    print(solution())
}
