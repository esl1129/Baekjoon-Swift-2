func solution() -> Int{
    let fIO = FileIO()
    let N = fIO.readInt()
    let M = fIO.readInt()
    var fixed = [Bool](repeating: false, count: N+2)
    for _ in 0..<M{
        fixed[fIO.readInt()] = true
    }
    fixed[N+1] = true
    var dp = [1,1,2]
    if N == 1 { return 1 }
    if N == 2 {
        if fixed[2] {
            return 1
        }
        return 2
    }
    for i in 3...N{
        dp.append(dp[i-1]+dp[i-2])
    }
    
    var s = 0
    var ans = 1
    for i in 1...N+1{
        if !fixed[i] {
            s += 1
            continue
        }
        ans *= dp[s]
        s = 0
    }
    return ans == 0 ? 1 : ans
}
