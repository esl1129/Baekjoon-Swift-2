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

struct conf: Hashable{
    let start: Int
    let end: Int
    
    init(_ s: Int, _ e: Int){
        self.start = s
        self.end = e
    }
}
func solution() -> Int{
    let fIO = FileIO()
    let N = fIO.readInt()
    var confArr = [conf]()
    
    for _ in 0..<N{
        confArr.append(conf(fIO.readInt(), fIO.readInt()))
    }
    
    confArr = confArr.sorted{$0.end < $1.end}.sorted{$0.end <= $1.end && $0.start < $1.start}
    var answer = [conf(0, 0)]
    var cnt = 0
    for con in confArr{
        if cnt == 0 {
            answer.append(con)
            cnt += 1
            continue
        }
        if answer[cnt].end > con.end {
            answer[cnt] = con
            continue
        }
        
        if answer[cnt].end <= con.start{
            answer.append(con)
            cnt += 1
        }
        
    }
    return answer.count-1
}

print(solution())
