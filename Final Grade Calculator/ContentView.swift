//
//  ContentView.swift
//  Final Grade Calculator
//
//  Created by Benny Chopra on 10/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentGradeTextField = ""
    @State private var finalWeightTextField = ""
    @State private var desiredGrade = 0.0
    @State private var requiredGrade = 0.0
    
    var body: some View {
        VStack {
            Text("Final Grade Calculator")
                .font(.largeTitle).bold()
            CustomTextField(placeholder: "Current Semester Grade", variable: $currentGradeTextField)
            CustomTextField(placeholder: "Final Grade Weight %", variable: $finalWeightTextField)
            Picker("Desired Semester Grade", selection: $desiredGrade) {
                Text ("A") .tag (90.0)
                Text ("B") .tag (80.0)
                Text ("C") .tag (70.0)
                Text ("D") .tag (60.0)
            }
            .pickerStyle (.segmented)
            .padding ()
            Text("Required Grade on Final")
                .font(.title)
            CustomText(text: String(format: "%.1f", requiredGrade))
                .font(.title)
                .bold()
            
            Spacer()
        }
        .padding()
        .onChange(of: desiredGrade) { oldValue, newValue in
            calculateGrade ()
        }
        .background (requiredGrade > 100 ? Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0.0))
    }
    
    func calculateGrade() {
        if let currentGrade = Double(currentGradeTextField) {
            if let finalWeight = Double(finalWeightTextField) {
                if finalWeight < 100 && finalWeight > 0 {
                    let finalPercentage = finalWeight / 100.0
                    requiredGrade = max(0.0, (desiredGrade - (currentGrade * (1.0 - finalPercentage))) / finalPercentage)
                }
                
            }
        }
    }
}

struct CustomTextField: View {
    let placeholder: String
    let variable: Binding<String>
    var body: some View {
        TextField(placeholder, text: variable)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .frame(width: 200, height: 30)
    }
}

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
}

#Preview  {
    ContentView()
}

