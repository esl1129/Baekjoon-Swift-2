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
    let x: Int
    let y: Int
}
func solution() -> String{
    let dx = [1,0,-1,0]
    let dy = [0,1,0,-1]
    
    let fIO = FileIO()
    let N = fIO.readInt()
    let arr = fIO.readString().map{String($0)}
    var start = Point(x: 0, y: 0)
    var pSet = Set<Point>()
    pSet.insert(start)
    var dir = 0
    for a in arr{
        if a == "L" { dir = dir == 3 ? 0 : dir+1 }
        if a == "R" { dir = dir == 0 ? 3 : dir-1 }
        if a == "F" {
            start = Point(x: start.x+dx[dir], y: start.y+dy[dir])
            pSet.insert(start)
        }
    }
    var answerArr = [String]()
    for i in pSet.map{$0.x}.min()!...pSet.map{$0.x}.max()!{
        var s = ""
        for j in pSet.map{$0.y}.min()!...pSet.map{$0.y}.max()!{
            if pSet.contains(Point(x: i, y: j)){
                s += "."
            } else {
                s += "#"
            }
        }
        answerArr.append(s)
    }
    return answerArr.joined(separator: "\n")
}
print(solution())
