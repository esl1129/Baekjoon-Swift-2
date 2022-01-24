func solution(){
    func draw(_ s:Int, _ e: Int, _ check: Bool){
        if check {
            for i in s...e{
                answer[s][i] = "*"
                answer[i][s] = "*"
                answer[e][i] = "*"
                answer[i][e] = "*"
            }
        } else {
            for i in s...e{
                answer[s][i] = " "
                answer[i][s] = " "
                answer[e][i] = " "
                answer[i][e] = " "
            }
        }
    }
    let N = 4*Int(readLine()!)!-3
    var answer = [[String]](repeating: [String](repeating: "", count: N), count: N)
    
    var start = 0
    var end = N-1
    var check = true
    while start <= end {
        draw(start, end, check)
        check = check ? false : true
        start += 1
        end -= 1
    }
    for ans in answer {
        print(ans.joined())
    }
}

solution()
