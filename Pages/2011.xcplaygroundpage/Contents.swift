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

struct cnt{
    let no: Int
    let le: Int
    let ri: Int
    func getSum() -> Int{
        return no+le+ri
    }
}
func solution() -> Int{
    let fIO = FileIO()
    let arr = fIO.readString().map{Int(String($0))!}
    if arr.isEmpty || arr[0] == 0{
        return 0
    }
    if arr.count == 1{
        return 1
    }
    var small = 1
    var large = 0
    for i in stride(from: arr.count-2, to: -1, by: -1){
        let s = arr[i+1] != 0 ? small+large : large
        large = 0
        if arr[i] < 3 && arr[i] > 0{
            if arr[i] < 2 || arr[i+1] < 7{
                large = small
            }
        }
        small = s%1000000
    }
    return (small+large)%1000000
}
print(solution())
