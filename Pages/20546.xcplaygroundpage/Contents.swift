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

func solution() -> String{
    let N = fIO.readInt()
    
    var bnp = N
    var bnpCnt = 0
    var tim = N
    var timCnt = 0
    
    var price = [Int]()
    for _ in 0..<13{
        price.append(fIO.readInt())
    }
    let last = fIO.readInt()
    
    var t = 0
    
    for i in 0..<price.count{
        bnpCnt += bnp/price[i]
        bnp -= (bnp/price[i])*price[i]
        
        if i == 0 { continue }
        if price[i] == price[i-1] {
            t = 0
        } else {
            if price[i] < price[i-1] {
                if t < 0 {
                    t -= 1
                } else {
                    t = -1
                }
            } else {
                if t > 0 {
                    t += 1
                } else {
                    t = 1
                }
            }
        }
        if t >= 3 {
            tim += price[i]*timCnt
            timCnt = 0
            continue
        }
        if t <= -3 {
            timCnt += tim/price[i]
            tim -= (tim/price[i])*price[i]
            continue
        }
    }
    bnp += bnpCnt*last
    tim += timCnt*last
    return bnp == tim ? "SAMESAME" : bnp > tim ? "BNP" : "TIMING"
}

print(solution())
