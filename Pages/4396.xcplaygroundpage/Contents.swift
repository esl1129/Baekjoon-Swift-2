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

let dx = [0,1,1,1,0,-1,-1,-1]
let dy = [1,1,0,-1,-1,-1,0,1]
func solution(){
    func isBound(_ xx: Int, _ yy: Int) -> Bool {
        return xx >= 0 && yy >= 0 && xx < N && yy < N
    }
    let fIO = FileIO()
    let N = fIO.readInt()
    var mines = [[String]]()
    for _ in 0..<N{
        mines.append(fIO.readString().map{String($0)})
    }
    
    var board = [[String]]()
    for _ in 0..<N{
        board.append(fIO.readString().map{String($0)})
    }
    
    var end = false
    for i in 0..<N{
        for j in 0..<N{
            if board[i][j] == "." { continue }
            if mines[i][j] == "*" {
                end = true
                continue
            }
            var cnt = 0
            for k in 0..<8{
                let xx = i+dx[k]
                let yy = j+dy[k]
                if !isBound(xx, yy) { continue }
                if mines[xx][yy] == "*" { cnt += 1}
            }
            board[i][j] = String(cnt)
        }
    }
    if end {
        for i in 0..<N{
            for j in 0..<N{
                if mines[i][j] != "*" { continue }
                board[i][j] = "*"
            }
        }
    }
    for i in 0..<N{
        print(board[i].joined())
    }
}

solution()
