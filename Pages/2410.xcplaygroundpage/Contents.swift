func solution() -> Int{
    let MOD = 1000000000
    let fIO = FileIO()
    let N = fIO.readInt()
    var dp = [Int](repeating: 0, count: N+1)
    var numbers: [Int] = []
    var t = 1
    while t <= 1000000 {
        numbers.append(t)
        t *= 2
    }
    dp[0] = 1
    
    for num in numbers.reversed(){
        for i in 1...N{
            if i < num { continue }
            dp[i] += dp[i-num]%MOD
            dp[i] %= MOD
        }
    }
    return dp[N]
}
