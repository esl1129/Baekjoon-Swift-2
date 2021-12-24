import Foundation

let N = Int(readLine()!)!
let K = Int(readLine()!)!

var arr = [Int](repeating: 0, count: N+1)
for i in 1...N{
    arr[i] = i
}

for _ in 0..<K{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let min = arr[line[0]] < arr[line[1]] ? arr[line[0]] : arr[line[1]]
    let max = arr[line[0]] > arr[line[1]] ? arr[line[0]] : arr[line[1]]

    for i in 1...N{
        if arr[i] == max { arr[i] = min }
    }
}

print(arr.filter{$0 == 1}.count-1)

