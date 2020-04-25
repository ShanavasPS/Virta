//
//  LoginView.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    @EnvironmentObject var session: SessionStore
    @State private var username = "candidate1@virta.global"
    @State private var password = "1Candidate!"
    @State var loggedIn = false
    
    var body: some View {
        VStack {
            Text("Log In and Charge!").fontWeight(.bold)
            Image("logIn").resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 150, alignment: .center)
            HStack {
                Image("icPerson").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
                TextField("Username", text: $username)
                .padding()
            }
            HStack {
                Image("icLock").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
                SecureField("Password", text: $password)
                .padding()
            }
            Button(action: {
                self.networkManager.loginUser(username: self.username, password: self.password) { (result) in
                    DispatchQueue.main.async {
                        self.session.accessToken = try? result.get()
                    }
                }
            }, label: { Text("Login")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal) })
                .background(Color.yellow)
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionStore())
    }
}
