//
//  ContentView.swift
//  CalcSwiftUI
//
//  Created by Terry Kuo on 2021/2/8.
//

import SwiftUI

enum CalculatorButton: String {
    case zero = "0" ,one = "1", two = "2", three = "3", four = "4", five = "5",six = "6", seven = "7" ,eight = "8", nine = "9"
    case equals = "=", plus = "+", minus = "-", multiply = "X", divide = "÷"
    case ac = "AC", plusMinus = "±", percent = "%"
    case dot = ".", delete = "Del"
    
    
    var backGroundColor: Color {
        switch self {
        case .minus, .multiply, .divide, .plus, .equals:
            return Color(.orange)
        case .ac, .plusMinus,. percent:
            return Color(.lightGray)
        case .delete:
            return Color(.red)
        default:
            return .green
        }
    }
}

class GlobalEnvironment: ObservableObject {
    
    @Published var display = "0"
    
    func receiveInput(calcValue: CalculatorButton) {
        display = calcValue.rawValue
    }
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    
    let numbers: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.delete, .zero, .dot, .equals]
    ]
    
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            Color.black.ignoresSafeArea(.all)
            
            
            VStack(spacing: 12) {
                
                HStack {
                    Spacer()
                    Text(env.display)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                        .padding()
                }
                ForEach(numbers, id: \.self) { (row) in
                    HStack (spacing: 12){
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        } //ForEach In
                    } //HStack
                } //ForEach out
            } //VStack
        } //ZStack
    } //body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button(action: {
            env.receiveInput(calcValue: button)
        }, label: {
            Text(button.rawValue)
                .font(.system(size: 32)).bold()
                .frame(width: self.buttomWidth(), height: self.buttomWidth())
                .foregroundColor(.white)
                .background(button.backGroundColor)
                .cornerRadius(self.buttomWidth())
        })
    }
    private func buttomWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}
