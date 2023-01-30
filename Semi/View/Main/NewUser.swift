//
//  NewUser.swift
//  Semi
//
//  Created by 서종현 on 2023/01/12.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct NewUser: View {
    @Binding var model: ViewModel
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var passwordCheck = ""
    @State private var userName = ""
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .foregroundStyle(.linearGradient(colors: [.white, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            
            VStack {
                Text("회원가입")
                    .foregroundColor(.blue)
                    .bold()
                    .padding(.bottom)
                    .offset(y: -210)
                
    // Email 입력 textfield
                TextField("이메일", text: $email)
                    .foregroundColor(.accentColor)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("이메일")
                            .foregroundColor(.accentColor)
                            .bold()
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.accentColor)
                
    //password 입력 textfield
                SecureField("비밀번호", text: $password)
                    .foregroundColor(.blue)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("비밀번호")
                            .foregroundColor(.accentColor)
                            .bold()
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.accentColor)
                
    // password check
                SecureField("비밀번호 확인", text: $passwordCheck)
                    .foregroundColor(.blue)
                    .textFieldStyle(.plain)
                    .placeholder(when: passwordCheck.isEmpty) {
                        Text("비밀번호 확인")
                            .foregroundColor(.accentColor)
                            .bold()
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.accentColor)
                
    //이름 입력
                TextField("이름", text: $userName)
                    .foregroundColor(.accentColor)
                    .textFieldStyle(.plain)
                    .placeholder(when: userName.isEmpty) {
                        Text("이름")
                            .foregroundColor(.accentColor)
                            .bold()
                    }
                    .autocorrectionDisabled()
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.accentColor)
                
//회원가입 버튼
                
                Button {
                    register()
                } label: {
                    Text("회원가입")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.blue, .blue], startPoint: .top, endPoint: .bottom))
                        )
                }
                .padding(.top)
                .offset(y: 100)
            }
            .padding()
        }
    }
    
    
    func register() {
        if(password == passwordCheck){
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    isLoggedIn = true
                    let uid = Auth.auth().currentUser?.uid ?? "UserID"
                    let db = Firestore.firestore()
                    let ref = db.collection("Users").document(uid)
                    ref.setData(["Email": email, "UserName": userName]) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        } else {
            passwordCheck = ""
        }
        
    }
}

struct NewUser_Previews: PreviewProvider {
    static var previews: some View {
        NewUser(model: .constant(.init()), isLoggedIn: .constant(false))
    }
}
