import Foundation

struct Edge{
    let s: Int
    let e: Int
    init(_ s:Int, _ e: Int){
        self.s = s
        self.e = e
    }
}

let dx = [-1,0,1,0]
let dy = [0,-1,0,1]

func solution() -> String{
    let P = Int(readLine()!)!
    var b = [[Int]]()
    b.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    for _ in 0..<P{
        b.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    }
    b.append(readLine()!.components(separatedBy: " ").map{Int(String($0))!})
    var visited = [Int](repeating: 0, count: b.count)
    for i in 1..<b.count{
        visited[i] = i
    }
    
    var edges = [Edge]()
    for i in 0..<b.count-1{
        for j in i+1..<b.count{
            if abs(b[i][0]-b[j][0])+abs(b[i][1]-b[j][1]) > 1000 { continue }
            edges.append(Edge(i, j))
        }
    }
    for edge in edges {
        if visited[edge.s] == visited[edge.e] { continue }
        let min = visited[edge.s] < visited[edge.e] ? visited[edge.s] : visited[edge.e]
        let max = visited[edge.s] > visited[edge.e] ? visited[edge.s] : visited[edge.e]
        for i in visited.indices{
            if visited[i] == max { visited[i] = min }
        }
        if visited[b.count-1] == 0 { return "happy" }
    }
    return "sad"
}

let TC = Int(readLine()!)!
for _ in 0..<TC{
    print(solution())

}
