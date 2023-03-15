import SwiftUI

struct Num: Hashable{
    var number: Int
    var color: Bool
}
struct Chip {
    var value: Int
    var color: Color
}
struct ContentView: View {
    @State private var nums = [
        [ Num(number: 1, color: true), Num(number: 2, color: false), Num(number: 3, color: true)],
        [ Num(number: 4, color: false), Num(number: 5, color: true), Num(number: 6, color: false)],
        [ Num(number: 7, color: true), Num(number: 8, color: false), Num(number: 9, color: true)],
        [ Num(number: 10, color: false), Num(number: 11, color: false), Num(number: 12, color: true)],
        [ Num(number: 13, color: false), Num(number: 14, color: true), Num(number: 15, color: false)],
        [ Num(number: 16, color: true), Num(number: 17, color: false), Num(number: 18, color: true)],
        [ Num(number: 19, color: true), Num(number: 20, color: false), Num(number: 21, color: true)],
        [ Num(number: 22, color: false), Num(number: 23, color: true), Num(number: 24, color: false)],
        [ Num(number: 25, color: true), Num(number: 26, color: false), Num(number: 27, color: true)],
        [ Num(number: 28, color: false), Num(number: 29, color: false), Num(number: 30, color: true)],
        [ Num(number: 31, color: false), Num(number: 32, color: true), Num(number: 33, color: false)],
        [ Num(number: 34, color: true), Num(number: 35, color: false), Num(number: 36, color: true)]
    ]
    @State private var chips = [
        Chip(value: 1, color: .red),
        Chip(value: 5, color: .green),
        Chip(value: 10, color: .blue),
        Chip(value: 50, color: .purple),
        Chip(value: 100, color: Color(red : 0xF9/255, green:0xB5/255, blue:0xA8/255))
    ]
    @State private var board: [String: Int] = [:]
    @State private var last_board: [String: Int] = [:]
    @State private var now_chip_index = -1
    @State private var show_border = false
    @State private var show_alert = false
    @State private var show_spin = false
    @State private var show_error = false
    @State private var no_money = false
    @State private var added_money = 0
    @State private var rd = -1
    @State private var money = 1000000
    let oddArr = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35]
    let evenArr = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36]
    let row1Arr = [1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34]
    let row2Arr = [2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35]
    let row3Arr = [3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36]
    let firstArr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    let secondArr = [13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
    let thirdArr = [25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]
    let redArr = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]
    let blackArr = [2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35]
    let frontArr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
    let backArr = [19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]
    fileprivate func updateBoard(s: String) {
        if money >= chips[now_chip_index].value * 1000 {
            board[s, default: 0] += chips[now_chip_index].value
            money -= chips[now_chip_index].value * 1000
        } else {
            no_money = true
        }
    }
    
    fileprivate func update_money(_ data: Dictionary<String, Int>.Element) {
        if data.key == "Odd" && oddArr.contains(rd) {
            added_money += data.value * 1000 * 2
        }
        if data.key == "Even" && evenArr.contains(rd) {
            added_money += data.value * 1000 * 2
        }
        if data.key == "Red" && redArr.contains(rd) {
            added_money += data.value * 1000 * 2
        }
        if data.key == "Black" && blackArr.contains(rd) {
            added_money += data.value * 1000 * 2
        }
        if data.key == "1 - 18" && frontArr.contains(rd) {
            added_money += data.value * 1000 * 2
        }
        if data.key == "19-36" && backArr.contains(rd) {
            added_money += data.value * 1000 * 2
        }
        if data.key == "1st 12" && firstArr.contains(rd) {
            added_money += data.value * 1000 * 3
        }
        if data.key == "2nd 12" && secondArr.contains(rd) {
            added_money += data.value * 1000 * 3
        }
        if data.key == "3rd 12" && thirdArr.contains(rd) {
            added_money += data.value * 1000 * 3
        }
        if data.key == "row 1" && row1Arr.contains(rd) {
            added_money += data.value * 1000 * 3
        }
        if data.key == "row 2" && row2Arr.contains(rd) {
            added_money += data.value * 1000 * 3
        }
        if data.key == "row 3" && row3Arr.contains(rd) {
            added_money += data.value * 1000 * 3
        }
        if data.key == String(rd) {
            added_money += data.value * 1000 * 36
        }
        if data.key == "00" && rd == 37 {
            added_money += data.value * 1000 * 36
        }
    }
    
    var body: some View {
        ZStack{
            Button("1"){}
                .alert("You don't have enough money!", isPresented: $no_money, actions: {
                    Button("Sad"){}
                })
            Image("lightsky")
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .ignoresSafeArea()
            
            HStack (alignment: .top, spacing: 20) {
                VStack (spacing: -90) {
                    VStack (spacing: 0) {
                        VStack (spacing: 0) {
                            HStack (spacing: 0){
                                Text("00")
                                    .frame(width: 90, height: 40, alignment: .center)
                                    .border(Color.white)
                                    .onTapGesture{
                                        if now_chip_index != -1 {
                                            updateBoard(s: "00")
                                        }
                                    }
                                Text("0")
                                    .frame(width: 90, height: 40, alignment: .center)
                                    .border(Color.white)
                                    .onTapGesture{
                                        if now_chip_index != -1 {
                                            updateBoard(s: "0")
                                        }
                                    }
                            }
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            VStack (spacing: 0) {
                                ForEach(nums, id: \.self) { row in
                                    HStack (spacing: 0) {
                                        ForEach(row, id: \.self) { data in
                                            ZStack{
                                                Text("\(data.number)")
                                                    .frame(width: 60, height: 40)
                                                    .foregroundColor(Color.white)
                                                    .background(data.color ? Color.red : Color.black)
                                                    .border(Color.white)
                                                    .onTapGesture{
                                                        if now_chip_index != -1 {
                                                            updateBoard(s: "\(data.number)")
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            HStack (spacing: 0) {
                                ForEach(1..<4, id: \.self) { i in
                                    Text("row \(i)")
                                        .frame(width: 60, height: 40, alignment: .center)
                                        .border(Color.white)
                                        .onTapGesture{
                                            if now_chip_index != -1 {
                                                updateBoard(s: "row \(i)")
                                            }
                                        }
                                }
                            }
                            .foregroundColor(Color.white)
                            .background(Color.green)
                        }
                        .rotationEffect(.degrees(270))
                        .offset(x: 0.0, y: -100)
                    }
                    VStack (spacing: 0){
                        HStack (spacing: 0){
                            Text("1st 12")
                                .frame(width: 160, height: 40, alignment: .center)
                                .border(Color.white)
                                .onTapGesture{
                                    if now_chip_index != -1 {
                                        updateBoard(s: "1st 12")
                                    }
                                }
                            Text("2nd 12")
                                .frame(width: 160, height: 40, alignment: .center)
                                .border(Color.white)
                                .onTapGesture{
                                    if now_chip_index != -1 {
                                        updateBoard(s: "2nd 12")
                                    }
                                }
                            Text("3rd 12")
                                .frame(width: 160, height: 40, alignment: .center)
                                .border(Color.white)
                                .onTapGesture{
                                    if now_chip_index != -1 {
                                        updateBoard(s: "3rd 12")
                                    }
                                }
                        }
                        HStack (spacing: 0){
                            Text("1 - 18")
                                .frame(width: 80, height: 40, alignment: .center)
                                .border(Color.white)
                                .onTapGesture{
                                    if now_chip_index != -1 {
                                        updateBoard(s: "1 - 18")
                                    }
                                }
                            Text("Even")
                                .frame(width: 80, height: 40, alignment: .center)
                                .border(Color.white)
                                .onTapGesture{
                                    if now_chip_index != -1 {
                                        updateBoard(s: "Even")
                                    }
                                }
                            Text("Red")
                                .frame(width: 80, height: 40, alignment: .center)
                                .border(Color.white)
                                .onTapGesture{
                                    if now_chip_index != -1 {
                                        updateBoard(s: "Red")
                                    }
                                }
                            Text("Black")
                                .frame(width: 80, height: 40, alignment: .center)
                                .border(Color.white)
                                .onTapGesture{
                                    if now_chip_index != -1 {
                                        updateBoard(s: "Black")
                                    }
                                }
                            Text("Odd")
                                .frame(width: 80, height: 40, alignment: .center)
                                .border(Color.white)
                                .onTapGesture{
                                    if now_chip_index != -1 {
                                        updateBoard(s: "Odd")
                                    }
                                }
                            Text("19-36")
                                .frame(width: 80, height: 40, alignment: .center)
                                .border(Color.white)
                                .onTapGesture{
                                    if now_chip_index != -1 {
                                        updateBoard(s: "19-36")
                                    }
                                }
                        }
                    }
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .offset(x: 0, y: -200)
                    HStack (spacing: 50) {
                        HStack (spacing: 20) {
                            ForEach(0..<chips.count, id:\.self) { index in
                                ZStack {
                                    Text("\(chips[index].value)K")
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .background(chips[index].color)
                                        .clipShape(Circle())
                                        .onTapGesture {
                                            if show_border && now_chip_index == index {
                                                now_chip_index = -1
                                                show_border = false
                                            } else {
                                                now_chip_index = index
                                                show_border = true
                                            }
                                        }
                                    if show_border && now_chip_index == index {
                                        Circle()
                                            .strokeBorder(Color.black, lineWidth: 2)
                                            .frame(width: 50, height: 50, alignment: .center)
                                    }
                                }
                            }
                        }
                        .frame(width: 350, height: 58, alignment: .center)
                        .background(Color(red: 103/255, green: 52/255, blue: 42/255))
                        
                        HStack(spacing: 30){
                            Button("REBET", action:{
                                if last_board.isEmpty {
                                    show_alert = true
                                } else {
                                    var cost = 0
                                    last_board.forEach { data in
                                        cost += data.value * 1000
                                    }
                                    if cost > money {
                                        no_money = true
                                    } else {
                                        var sum = 0
                                        board.forEach { data in
                                            sum += data.value * 1000
                                        }
                                        money += sum
                                        money -= cost
                                        board = last_board
                                    }
                                    
                                }
                            })
                                .alert("haven't bet yet", isPresented: $show_alert, actions: {
                                    Button("OK"){}
                                })
                                .frame(width: 70, height: 50, alignment: .center)
                                .background(Color.white)
                                .foregroundColor(Color.black)
                            
                            Button("CLEAR", action:{
                                var sum = 0
                                board.forEach { data in
                                    sum += data.value * 1000
                                }
                                money += sum
                                board.removeAll()
                            })
                                .frame(width: 70, height: 50, alignment: .center)
                                .background(Color.white)
                                .foregroundColor(Color.black)
                            
                            Button("SPIN", action:{
                                if board.isEmpty {
                                    show_error = true
                                } else {
                                    show_spin = true
                                    rd = Int.random(in: 0...37)
                                    added_money = 0
                                    board.forEach { data in
                                        update_money(data)
                                    }
                                    money += added_money
                                    last_board = board
                                    board.removeAll()
                                }
                            })
                                .alert("haven't bet yet", isPresented: $show_error, actions: {
                                    Button("OK"){}
                                })
                                .alert("Congratulations!\n You got \(added_money) dollars", isPresented: $show_spin, actions: {
                                    Button("Nice!"){}
                                })
                                .frame(width: 90, height: 90, alignment: .center)
                                .background(Color(red: 0/255, green: 110/255, blue: 0/255))
                                .clipShape(Circle())
                                .foregroundColor(Color.white)
                            
                        }
                    }
                    .offset(x: 0, y: -75)
                }
            }
            .font(.title2)
            ZStack (alignment: .topLeading) {
                Rectangle()
                    .frame(width: 100.0, height: 100.0)
                    .foregroundColor(Color.orange)
                VStack {
                    Text("Lucky Num:")
                    if show_spin {
                        Text("\(rd != 37 ? String(rd) : "00")")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .position(x: 740, y: 200)
            ZStack (alignment: .leading) {
                Rectangle()
                    .frame(width: 150.0, height: 50.0)
                    .foregroundColor(Color.orange)
                Text("Money:\n\(money)")
                    .padding()
            }
            .position(x: 720, y: 300)
            
            ZStack (alignment: .leading) {
                Rectangle()
                    .frame(width: 100.0, height: 300.0)
                    .foregroundColor(Color.orange)
                VStack(spacing: -10){
                    Text("Your Bet:")
                        .frame(width: 100, height: 30, alignment: .leading)
                    ForEach(board.sorted(by: >), id: \.key) { key, data in
                        Text("\(key): \(data)K")
                    }
                        .frame(width: 100, height: 30, alignment: .leading)
                }
                .font(.body)
                .frame(width: 100, height: 300, alignment: .topLeading)
            }
            .position(x: 50, y: 240)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
