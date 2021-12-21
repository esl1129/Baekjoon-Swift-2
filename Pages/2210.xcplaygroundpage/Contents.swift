import Foundation

let dx = [0,1,0,-1]
let dy = [1,0,-1,0]
var board = [[String]]()
var strSet = Set<String>()

func DFS(_ x: Int, _ y: Int, _ depth: Int, _ str: String){
    if depth == 6 {
        strSet.insert(str)
        return
    }
    for k in 0..<4{
        let xx = x+dx[k]
        let yy = y+dy[k]
        if !isBound(xx, yy) { continue }
        DFS(xx, yy, depth+1, str+board[xx][yy])
    }
    return
}
func isBound(_ xx: Int, _ yy: Int) -> Bool{
    return xx >= 0 && yy >= 0 && xx < 5 && yy < 5
}

func solution(){
    for _ in 0..<5{
        board.append(readLine()!.components(separatedBy: " "))
    }
    for i in 0..<5{
        for j in 0..<5{
            DFS(i,j,1,board[i][j])
        }
    }
    print(strSet.count)
}

solution()
