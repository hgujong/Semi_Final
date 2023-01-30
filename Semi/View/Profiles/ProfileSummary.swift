//
//  ProfileSummary.swift
//  Semi
//
//  Created by 서종현 on 2023/01/12.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct ProfileSummary: View {
    @Binding var model: ViewModel
    @Binding var isLoggedIn: Bool
    var image: Image
    
    
    var body: some View {
        VStack {
            image
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .padding(.bottom)
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("User Name: ")
                        .bold()
                    
                    Text("User Email: ")
                        .bold()
                }
                .padding([.horizontal])
                
                VStack(alignment: .leading) {
                    Text(model.username)
                        .bold()
                    
                    Text(model.useremail)
                        .bold()
                }
                .padding([.horizontal])
            }
            
            // 로그아웃 버튼
            Button {
                do {
                    try Auth.auth().signOut()
                    print("signout works")
                    isLoggedIn = false
                } catch let signOurError as NSError {
                    print("ERROR: signout \(signOurError.localizedDescription)")
                }
            } label: {
                Text("로그아웃")
                    .foregroundColor(.red)
                    .bold()
            }
            .padding()
            
            
            Spacer()
        }
        .padding()
    }
    
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(model: .constant(.init()), isLoggedIn: .constant(false), image: Image("ProfilePic"))
    }
}
