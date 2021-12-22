import Foundation

struct Water: Hashable{
    let a: Int
    let b: Int
    let c: Int
    init(_ a: Int,_ b: Int,_ c:Int){
        self.a = a
        self.b = b
        self.c = c
    }
}
func solution() -> String{
    let line = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
    let A = line[0]
    let B = line[1]
    let C = line[2]
    let start = Water(0, 0, C)
    var answer: Set<Int> = []
    var visitedSet: Set<Water> = [start]
    var q = [start]
    while !q.isEmpty{
        let w = q.removeFirst()
        if w.a == 0 { answer.insert(w.c) }
        if w.a != 0 {
            let ab = [B-w.b,w.a].min()!
            let new1 = Water(w.a-ab, w.b+ab, w.c)
            if !visitedSet.contains(new1){
                q.append(new1)
                visitedSet.insert(new1)
            }
            let ac = [C-w.c,w.a].min()!
            let new2 = Water(w.a-ac, w.b, w.c+ac)
            if !visitedSet.contains(new2){
                q.append(new2)
                visitedSet.insert(new2)
            }
        }
        if w.b != 0{
            let ba = [A-w.a,w.b].min()!
            let new1 = Water(w.a+ba, w.b-ba, w.c)
            if !visitedSet.contains(new1){
                q.append(new1)
                visitedSet.insert(new1)
            }
            let bc = [C-w.c,w.b].min()!
            let new2 = Water(w.a, w.b-bc, w.c+bc)
            if !visitedSet.contains(new2){
                q.append(new2)
                visitedSet.insert(new2)
            }
        }
        if w.c != 0{
            let ca = [A-w.a,w.c].min()!
            let new1 = Water(w.a+ca, w.b, w.c-ca)
            if !visitedSet.contains(new1){
                q.append(new1)
                visitedSet.insert(new1)
            }
            let cb = [B-w.b,w.c].min()!
            let new2 = Water(w.a, w.b+cb, w.c-cb)
            if !visitedSet.contains(new2){
                q.append(new2)
                visitedSet.insert(new2)
            }
        }
    }
    return answer.sorted().map{String($0)}.joined(separator: " ")
}
print(solution())
