//
//  DisablingForm.swift
//  CupcakeIsGoodLearn
//
//  Created by Bagus Triyanto on 04/07/20.
//  Copyright © 2020 Bagus Triyanto. All rights reserved.
//

import SwiftUI

struct DisablingForm: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Details")) {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                }
                .cornerRadius(20)
                
                Section {
                    Button("Sign Up") {
                        print("Creating Account...")
                    }
                }
                .disabled(username.isEmpty || email.isEmpty)
            }
            .navigationBarTitle(Text("SignUp Good"))
        }
    }
}

struct DisablingForm_Previews: PreviewProvider {
    static var previews: some View {
        DisablingForm()
    }
}
