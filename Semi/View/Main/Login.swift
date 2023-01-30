//
//  Login.swift
//  Semi
//
//  Created by 서종현 on 2023/01/12.
//

import SwiftUI
import Firebase

struct Login: View {
    @Binding var model: ViewModel
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var showPopup = false
    
    
    var body: some View {
        ZStack {
// 배경
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.white, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            VStack(spacing: 20) {
                Text("TODOY")
                    .foregroundColor(.accentColor)
                    .font(.system(size:40, weight: .bold))
                    .offset(x: -100, y: -100)
                
// Email 입력
                TextField("이메일", text: $email)
                    .foregroundColor(.accentColor)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("이메일")
                            .foregroundColor(.blue)
                            .bold()
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.blue)
                
//password 입력 textfield
                SecureField("비밀번호", text: $password)
                    .foregroundColor(.accentColor)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("비밀번호")
                            .foregroundColor(.blue)
                            .bold()
                    }
                    .autocapitalization(.none)
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.blue)
                
// 로그인 버튼
                Button {
                    login()
                } label: {
                    Text("로그인")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.blue, .blue], startPoint: .top, endPoint: .bottom))
                        )
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 100)
                
                
// 회원가입
                Button {
                    showPopup.toggle()
                } label: {
                    Text("회원가입")
                        .foregroundColor(.accentColor)
                        .underline()
                        .bold()
                }
                .sheet(isPresented: $showPopup){
                    NewUser(model: $model, isLoggedIn: $isLoggedIn)
                }
                .padding(.top)
                .offset(y: 110)
                
            }
            .frame(width: 350)
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        isLoggedIn.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
// Login 함수
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                print("login button works")
                model.getUserData()
                model.getTodoData(date: model.picked)
                print(model.username)
                isLoggedIn = true
                
            }
        }
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(model: .constant(.init()), isLoggedIn: .constant(false))
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

