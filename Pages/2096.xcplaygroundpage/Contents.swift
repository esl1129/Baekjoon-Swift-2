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

let dy = [-1,0,1]
func solution() -> String{
    let fIO = FileIO()
    let N = fIO.readInt()
    var arr = [[Int]](repeating: [], count: N)
    
    for i in 0..<N{
        for _ in 0..<3{
            arr[i].append(fIO.readInt())
        }
    }
    var minDp = arr
    var maxDp = arr
    
    for i in 1..<N{
        maxDp[i][0] += maxDp[i-1][0] > maxDp[i-1][1] ? maxDp[i-1][0] : maxDp[i-1][1]
        maxDp[i][1] += maxDp[i-1].max()!
        maxDp[i][2] += maxDp[i-1][2] > maxDp[i-1][1] ? maxDp[i-1][2] : maxDp[i-1][1]
        
        minDp[i][0] += minDp[i-1][0] < minDp[i-1][1] ? minDp[i-1][0] : minDp[i-1][1]
        minDp[i][1] += minDp[i-1].min()!
        minDp[i][2] += minDp[i-1][2] < minDp[i-1][1] ? minDp[i-1][2] : minDp[i-1][1]

    }
    return "\(maxDp[N-1].max()!) \(minDp[N-1].min()!)"
}
print(solution())
