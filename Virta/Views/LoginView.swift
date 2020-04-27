//
//  LoginView.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI
import MapKit
struct LoginView: View {
    @EnvironmentObject var session: SessionStore
    @State private var username = "candidate1@virta.global"
    @State private var password = "1Candidate!"
    @State private var showingAlert = false
    var body: some View {
        VStack {
            Text("Log In and Charge!").fontWeight(.bold).padding()
            Image("logIn").resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 150, alignment: .center)
            VStack {
                HStack {
                    Image("icPerson").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center).padding(.leading)
                    TextField("Username", text: $username)
                }
                Divider()
                    .padding(.leading)
                    .padding(.trailing)
            }
            VStack {
                HStack {
                    Image("icLock").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center).padding(.leading)
                    SecureField("Password", text: $password)
                }.padding(.top)
                Divider()
                    .padding(.leading)
                    .padding(.trailing)
            }
            Button(action: {
                self.session.loginUser(username: self.username, password: self.password)
            }, label: { Text("Log in")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 40)
                .padding(.vertical, 10)
            })
                .background(Color.yellow)
                .padding(40)
            Spacer()
        }
        .onReceive(session.$serviceFailed, perform: { serviceFailed in
            self.showingAlert = serviceFailed
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Warning"), message: Text("Wrong username or password"), dismissButton: .default(Text("OK!")) {
                self.session.serviceFailed = false })
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionStore())
    }
}
