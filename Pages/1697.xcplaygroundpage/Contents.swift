import Foundation

func solution() -> Int{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let s = line[0]
    let e = line[1]
    if s == e { return 0 }
    var q = [s]
    var visited = [Bool](repeating: false, count: 100001)
    visited[s] = true
    var ans = 1
    while !q.isEmpty{
        for _ in q.indices{
            let x = q.removeFirst()
            if x > 0 && !visited[x-1]{
                if x-1 == e { return ans }
                q.append(x-1)
                visited[x-1] = true
            }
            if x < 100000 && !visited[x+1]{
                if x+1 == e { return ans }
                q.append(x+1)
                visited[x+1] = true
            }
            if x <= 50000 && !visited[2*x]{
                if x*2 == e { return ans }
                q.append(x*2)
                visited[x*2] = true
            }
        }
        ans += 1
    }
    return ans
}

print(solution())
