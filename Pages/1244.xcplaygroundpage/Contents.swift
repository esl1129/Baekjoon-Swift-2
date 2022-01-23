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

let dx = [-1,1]
func solution(){
    func isBound(_ xx: Int) -> Bool {
        return xx > 0 && xx <= N
    }
    let fIO = FileIO()
    let N = fIO.readInt()
    var light = [-1]
    for _ in 0..<N{
        light.append(fIO.readInt())
    }
    let M = fIO.readInt()
    for _ in 0..<M{
        let gender = fIO.readInt()
        let idx = fIO.readInt()
        if gender == 1 {
            for i in stride(from: idx, to: N+1, by: idx){
                light[i] = light[i] == 0 ? 1 : 0
            }
        } else {
            var start = idx
            var end = idx
            while isBound(start) && isBound(end) {
                if light[start] != light[end] { break }
                start -= 1
                end += 1
            }
            for j in start+1..<end{
                light[j] = light[j] == 0 ? 1 : 0
            }
        }
    }
    var ans = [String]()
    for i in 1...N{
        ans.append(String(light[i]))
        if i%20 == 0{
            print(ans.joined(separator: " "))
            ans = []
        }
    }
    if !ans.isEmpty { print(ans.joined(separator: " ")) }
}

solution()
