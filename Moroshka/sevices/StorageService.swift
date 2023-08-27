//
//  StorageService.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 22.08.2023.
//

import Foundation
import FirebaseStorage

class StorageService {
    static let shared = StorageService()
    
    private init(){}
    
    private let storage = Storage.storage().reference()
    private var productsRef: StorageReference {
        storage.child("products")
    }
    func upload(id: String, image: Data, completion: @escaping(Result<String, Error>)-> ()) {
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        productsRef.child(id).putData(image, metadata: metadata) {metadata, error in
            guard let metadata = metadata else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success("\(metadata.size)"))
        }
    }
    func downLoadImage(id: String, completion: @escaping (Result<Data, Error>) -> ()) {
        productsRef.child(id).getData(maxSize: 2 * 1024 * 1024) { data, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
                return
            }
            completion(.success(data))
        }
    }
}
