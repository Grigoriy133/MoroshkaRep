//
//  DatabaseServices.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 19.08.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()
    private let db = Firestore.firestore()
  //создаем коллекцию пользователей
    private var userRef: CollectionReference {
        return db.collection("users")
    }
    
    private var orderRef: CollectionReference {
        return db.collection("orders")
    }
    
    private var productRef: CollectionReference {
        db.collection("products")
    }
    
    private init(){}
 
    func getOrders(by userId: String?, completion: @escaping (Result<[Order], Error>) -> ()) {
        self.orderRef.getDocuments{ qSnap, error in
            
            if let qSnap = qSnap {
                var orders = [Order]()
                for doc in qSnap.documents {
                    if userId == AuthService.shared.adminId {
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    } else if let userId = userId {
                        if let order = Order(doc: doc), order.userId == userId {
                            orders.append(order)
                        }
                    }                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getPositions(by orderId: String,  completion: @escaping (Result<[Position], Error>) -> ()){
        let positionsRef = orderRef.document(orderId).collection("positions")
        
        positionsRef.getDocuments {qSnap, error in
            if let querySnapshot = qSnap {
                var positions = [Position]()
                
                for doc in querySnapshot.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
 
    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> ()) {
        orderRef.document(order.id).setData(order.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.setPossitions(orderId: order.id, positions: order.possitions){ result in
                    
                    switch result {
                    case .success(let positions):
                        print(positions.count)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
                completion(.success(order))
            }
        }
    }
    
    func setPossitions(orderId: String, positions: [Position], completion: @escaping (Result<[Position], Error>) -> ()){
        let positionRef = orderRef.document(orderId).collection("positions")
        
        for position in positions {
            positionRef.document(position.id).setData(position.representation)
        }
        completion(.success(positions))
    }
    
    func setUser(user: UserModel, completion: @escaping (Result<UserModel, Error>) -> ()) {
        userRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getUser(by userId: String? = nil, completion: @escaping (Result<UserModel, Error>) -> ()) {
        userRef.document(userId != nil ? userId! : AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            
            guard let snap = docSnapshot else {return}
            
            guard let data = snap.data() else {return}
            
            guard let userName = data["name"] as? String else {return}
            guard let id = data["id"] as? String else {return}
            guard let phone = data["phone"] as? String else {return}
            guard let adress = data["adress"] as? String else {return}
            
            let user = UserModel(id: id, name: userName, phone: phone, adress: adress)
            
            completion(.success(user))
        }
    }
    
    func setProduct(product: ProductModel,image: Data, completion: @escaping (Result<ProductModel, Error>) -> ()) {
        StorageService.shared.upload(id: product.id, image: image) { result in
            switch result {
            case .success(_):
                self.productRef.document(product.id).setData(product.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(product))
                    }
                    
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func deleteProduct(product: ProductModel,completion: @escaping (Result<ProductModel, Error>) -> ()){
        self.productRef.document(product.id).delete() {error in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            } else {
                completion(.success(product))
            }
        }
    }
    
    func getProducts(comletion: @escaping(Result<[ProductModel], Error>) -> ()) {
        self.productRef.getDocuments { qSnap, error in
            guard let qSnap = qSnap else {
                if let error = error {
                    comletion(.failure(error))
                    print(error.localizedDescription)
                }
                return
            }
            let docs = qSnap.documents
                var products = [ProductModel]()
            for doc in docs {
                guard let product = ProductModel(doc: doc) else {return}
                products.append(product)
            }
            comletion(.success(products))
        }
    }
    
}
