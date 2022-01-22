func solution() -> String{
    var s = readLine()!
    var ans = ""
    while !s.isEmpty{
        var a = Int(String(s.removeLast()))!
        for _ in 0..<3{
            ans += String(a%2)
            a /= 2
        }
    }
    
    while ans.last == "0" {
        ans.removeLast()
    }
    return ans.isEmpty ? "0" : String(ans.reversed())
}

print(solution())
