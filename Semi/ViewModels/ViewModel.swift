//
//  ViewModel.swift
//  Semi
//
//  Created by 서종현 on 2023/01/12.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ViewModel: ObservableObject {
    @Published var todolist = [Todo]()
    @Published var username: String = ""
    @Published var useremail: String = ""
    @Published var date = Date()
    
    
    var uid = Auth.auth().currentUser?.uid ?? "Current UID"
    var email = Auth.auth().currentUser?.email ?? "Current Email"
    
    
    var picked: String {
        dateToString(date: date, format: "YYYY MM dd")
    }
    
    
    func addTodo(title: String, note: String, date: String){
        
        // Get a refernce to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("Users").document(uid).collection("Calendar").document(date).collection("todo").addDocument(data: ["title":title, "notes":note]) { error in
            
            // Check for errors
            if error == nil {
                // no error
                
                // Call get data to retrieve latest data
                self.getTodoData(date: date)
            }
            
            else {
                // Handle the error
            }
        }
    }
    
    
    
    func getUserData() {

        // Get a refernce to the database
        let db = Firestore.firestore()

        //Read the document
        db.collection("Users").document(uid).getDocument { document, error in

            // Check for errors
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    //print("data", data)
                    self.username = data["UserName"] as? String ?? ""
                    self.useremail = data["Email"] as? String ?? ""
                    print(self.username)
                }
            }
        }
    }
    
    
    func getTodoData(date: String) {
        
        // Get a refernce to the database
        let db = Firestore.firestore()
        
        //Read the documetns at a specific path
        db.collection("Users").document(uid).collection("Calendar").document(date).collection("todo").getDocuments { snapshot, error in
            
            //check for errors
            if error == nil {
                // No Errors
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        // Get all the documents and create Todos
                        self.todolist = snapshot.documents.map { d in
                            
                            return Todo(id: d.documentID,
                                        title: d["title"] as? String ?? "",
                                        notes: d["notes"] as? String ?? "")
                        }
                    }
                }
                
                print("Gettodo func working")
            }
            else {
                // Handle the error
            }
        }
    }
    
    
    func dateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
}
