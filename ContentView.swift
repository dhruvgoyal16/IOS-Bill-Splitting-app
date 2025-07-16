//
//  ContentView.swift
//  WeSplit
//
//  Created by Dhruv Goyal on 20/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var numberofpeople = 0 //here if no. of people is 0 which we have taken, this means that in picker the indexing for the least number of people wil be two so the indexing for two people will be 0 and therefore the default value will be 2 that will be shown in the picker,
//      if you assign this value as 2 then the default value shown in the picker will be 4.
//      uderstand this!
    
    @State private var tipPercentage = 20
    @FocusState private var amountisFoocused: Bool
    
    let tipPercentages = [0,10,15,20,25]
    
    var totalPerPperson: Double{
        let peoplecount = Double(numberofpeople + 2)
//        WE HAVE DONE +2 BECAUSE-
//        Our Picker for "Number of People" starts from 2 but stores values as 0, 1, 2, 3...           internally.
//        This means:
//        If numberofpeople = 0, actual people = 2
//        If numberofpeople = 1, actual people = 3
//        If numberofpeople = 2, actual people = 4
        let tipselection = Double(tipPercentage)
        
        let tipvalue = amount/100 * tipselection
        let Total = tipvalue + amount
        let amountPerPerson = Total/peoplecount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section{
                    TextField("Enter the amount:",value: $amount,format:.currency(code: "INR"))
                    // in the text field we have used 'value' keyword instead of 'text' as number is taken as input.
                        .keyboardType(.decimalPad).focused($amountisFoocused)
                    // here we have used keyboard type as decimal pad as so that whe user click on the textfield to enter the amount, directly the keyboard with nnumbers should open rather than the traditional keyboard.
                    Picker("Number of people",selection: $numberofpeople){
                        ForEach(2..<101) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                    //here if we use .pickerstyle(.navigationLink) then the new screen will open with more options to select from
                    //if you donnt use it then it will show a drop sown to select from
                }
                Section("How much do you want to tip?"){
                    //we have added a label to our section so like this
                    Picker("Select tip percentage",selection: $tipPercentage){
                        ForEach(tipPercentages,id:\.self){
                            Text($0,format:.percent)
                        }
                    }.pickerStyle(.segmented)
                }//we have used segmented to display the picker more visually apealing
                
                
                Section{
                    Text(totalPerPperson,format: .currency(code: "INR"))
                }
            }.navigationTitle("WeSplit")
                .toolbar{
                if amountisFoocused{
                    Button("Done"){
                        amountisFoocused = false
                    }//this is usedd to dismiss the keybard afteer the amount has been added
                }
            }
        }
    }
    
    
}
    #Preview {
        ContentView()
    }

