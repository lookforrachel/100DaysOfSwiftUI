//
//  ContentView.swift
//  TempConverter
//
//  Created by Rachel Yee on 10/23/21.
//

import SwiftUI

struct ContentView: View {
    @State private var initialValue = 0.0
    @State private var inputUnit = "m"
    @State private var outputUnit = "m"
    @FocusState private var valueIsFocused: Bool
    
    let units = ["m", "km", "ft", "yd", "mi"]
    
    var convertedValue: Double {
        
        var converted = 0.0
        
        if inputUnit != outputUnit {
            
            // metres
            if inputUnit == "m" && outputUnit == "km" {
                let toKm = initialValue / 1000
                converted = toKm
            } else if inputUnit == "m" && outputUnit == "ft" {
                let toFt = initialValue * 3.281
                converted = toFt
            } else if inputUnit == "m" && outputUnit == "yd" {
                let toYd = initialValue * 1.094
                converted = toYd
            } else if inputUnit == "m" && outputUnit == "mi" {
                let toMi = initialValue / 1609
                converted = toMi
            }
            
            // kilometres
            if inputUnit == "km" && outputUnit == "m" {
                let toKm = initialValue * 1000
                converted = toKm
            } else if inputUnit == "km" && outputUnit == "ft" {
                let toFt = initialValue * 3281
                converted = toFt
            } else if inputUnit == "km" && outputUnit == "yd" {
                let toYd = initialValue * 1094
                converted = toYd
            } else if inputUnit == "km" && outputUnit == "mi" {
                let toMi = initialValue / 1.609
                converted = toMi
            }
            
            // feet
            if inputUnit == "ft" && outputUnit == "m" {
                let toM = initialValue * 1000
                converted = toM
            } else if inputUnit == "ft" && outputUnit == "km" {
                let toFt = initialValue * 3281
                converted = toFt
            } else if inputUnit == "ft" && outputUnit == "yd" {
                let toYd = initialValue * 1094
                converted = toYd
            } else if inputUnit == "ft" && outputUnit == "mi" {
                let toMi = initialValue / 1.609
                converted = toMi
            }
            
            // yards
            if inputUnit == "yd" && outputUnit == "m" {
                let toM = initialValue / 1760
                converted = toM
            } else if inputUnit == "yd" && outputUnit == "km" {
                let toKm = initialValue / 1094
                converted = toKm
            } else if inputUnit == "yd" && outputUnit == "ft" {
                let toFt = initialValue * 3
                converted = toFt
            } else if inputUnit == "yd" && outputUnit == "mi" {
                let toMi = initialValue / 1760
                converted = toMi
            }
            
            // miles
            if inputUnit == "mi" && outputUnit == "m" {
                let toM = initialValue * 1609
                converted = toM
            } else if inputUnit == "mi" && outputUnit == "km" {
                let toKm = initialValue * 1.609
                converted = toKm
            } else if inputUnit == "mi" && outputUnit == "ft" {
                let toFt = initialValue * 5280
                converted = toFt
            } else if inputUnit == "mi" && outputUnit == "yd" {
                let toMi = initialValue * 1760
                converted = toMi
            }
            
        } else {
            converted = initialValue
        }
                
        return converted
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $initialValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                } header: {
                    Text("Initial value")
                }
                
                Section {
                    Picker("", selection: $inputUnit) {
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Input unit")
                }
                
                Section {
                    Picker("", selection: $outputUnit){
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Output unit")
                }
                
                Section {
                    Text(convertedValue, format: .number)
                } header: {
                    Text("Converted value")
                }
            }
            .navigationTitle("Length Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        valueIsFocused = false
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

