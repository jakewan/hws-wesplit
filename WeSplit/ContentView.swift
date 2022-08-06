//
//  ContentView.swift
//  WeSplit
//
//  Created by Jacob Wan on 7/24/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeopleIdx = 2
    @State private var tipPercentage = 20
    @FocusState private var amountHasFocus: Bool

    let tipOptions = [10, 15, 20, 25, 0]

    var calculateAmountPerPerson: Double {
        // Offset numberOfPeopleIdx by 2 because it's and index
        let countOfPeople = Double(numberOfPeopleIdx + 2)
        let tipSelection = Double(tipPercentage)
        let tipAmount = checkAmount * tipSelection / 100
        let total = checkAmount + tipAmount
        let totalPerPerson = total / countOfPeople
        return totalPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountHasFocus)

                    Picker("Number of people", selection: $numberOfPeopleIdx) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipOptions, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip percentage")
                }

                Section {
                    Text(calculateAmountPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountHasFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
