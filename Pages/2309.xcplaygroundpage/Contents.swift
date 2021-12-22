import Foundation


func solution() -> [Int]{
    var heights = [Int]()
    for _ in 0..<9{
        heights.append(Int(readLine()!)!)
    }
    let targetNum = heights.reduce(0, +) - 100
    for num in heights{
        if heights.contains(targetNum-num){
            if heights.firstIndex(of: num)! == heights.lastIndex(of: targetNum - num)! { continue }
            heights.remove(at: heights.firstIndex(of: num)!)
            heights.remove(at: heights.lastIndex(of: targetNum - num)!)

            return heights.sorted()
        }
    }
    return []
}
let arr = solution()
for a in arr{
    print(a)
}

