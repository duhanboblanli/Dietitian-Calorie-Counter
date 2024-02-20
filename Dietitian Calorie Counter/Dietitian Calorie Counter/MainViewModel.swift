//
//  MainViewModel.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 2.09.2023.
//

import Foundation
import UIKit
import SwiftUI
import PhotosUI

struct PickerResult{
    let image: UIImage
    let imageURL: URL
}
class MainViewModel: ObservableObject {
    
    init() {}
    
    func photosPickerTask(newItem: PhotosPickerItem?) async -> (UIImage?, URL?){
        
        print("SUCCESS")
        if let data = try? await newItem?.loadTransferable(type: Data.self){
            print("data: \(data)")
            let image: UIImage = UIImage(data: data)!
            if let contentType = newItem!.supportedContentTypes.first {
                // Step 2: make the URL file name and a get a file extention.
                let url = getDocumentsDirectory().appendingPathComponent("\(UUID().uuidString).\(contentType.preferredFilenameExtension ?? "")")
                do {
                    // Step 3: write to temp App file directory and return in completionHandler
                    try data.write(to: url)
                    return (image, url)
                } catch {
                    
                }
                
            }
        }
        return (nil,nil)
        
    }
    func getImageName(from pickerItem: PhotosPickerItem, completionHandler: @escaping (String?) -> Void) {
        if let localID = pickerItem.itemIdentifier {
            let result = PHAsset.fetchAssets(withLocalIdentifiers: [localID], options: nil)
            if let asset = result.firstObject {
                print(asset.localIdentifier)
                print("Got " + asset.debugDescription)
                completionHandler(asset.localIdentifier)
            }
        }
        completionHandler(nil)
    }
    func getURL(from: PhotosPickerItem, completionHandler: @escaping (_ result: Result<URL, Error>) -> Void) {
        // Step 1: Load as Data object.
        from.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let contentType = from.supportedContentTypes.first {
                    // Step 2: make the URL file name and a get a file extention.
                    let url = self.getDocumentsDirectory().appendingPathComponent("\(UUID().uuidString).\(contentType.preferredFilenameExtension ?? "")")
                    if let data = data {
                        do {
                            // Step 3: write to temp App file directory and return in completionHandler
                            try data.write(to: url)
                            completionHandler(.success(url))
                        } catch {
                            completionHandler(.failure(error))
                        }
                    }
                }
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
}

extension MainViewModel{
    
    
    //    struct Post{
    //        var userId: Int
    //        var id: Int
    //        var title: String
    //        var body: String
    //    }
    
    
    //    func getPosts(){
    //        API.Client.shared
    //            .get(.getall){ (result: Result<API.Types.Response.PostSearch, API.Types.Error>) in
    //
    //                print("result")
    //                print(result)
    //
    //                switch result {
    //                case .success(let success):
    //                    self.parseResults(success)
    //                case .failure(let failure):
    //                    print("failure: \(failure)")
    //                }
    //
    //
    //            }
    //    }
    //    func fetchResults(withQuery query: String) {
    //        API.Client.shared
    //            .get(.search(query: query)){ (result: Result<API.Types.Response.PostSearch, API.Types.Error>) in
    //
    //                print("result")
    //                print(result)
    //
    //                switch result {
    //                case .success(let success):
    //                    self.parseResults(success)
    //                case .failure(let failure):
    //                    print("failure: \(failure)")
    //                }
    //
    //
    //            }
    //    }
    //
    //    private func parseResults(_ results: API.Types.Response.PostSearch){
    //        var localResults = [Post]()
    //
    //        for result in results.posts{
    //            let localResult = Post(
    //                userId: result.userId,
    //                id: result.id,
    //                title: result.title,
    //                body: result.body)
    //        }
    //
    //        self.postResults = localResults
    //
    //    }
}



