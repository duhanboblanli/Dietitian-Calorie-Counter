import Foundation
import SwiftUI


enum NavigationScreen: Hashable{
    
    case onboarding
    case subscription
    case aicut
    case settings
    case FAQs
    case about
    case language
    case main

}

class NavigationController: ObservableObject{
    
    @Published var path: [NavigationScreen] = []
    @Published var aiCutOpen: Bool = false
    static let shared = NavigationController()
    
    private var image: UIImage? = nil
    private var imageURL: URL? = nil
    
    func preAICut(image: UIImage?, imageURL: URL?){
        self.image = image
        self.imageURL = imageURL
    }
    
    func getAICutItems() -> (UIImage?, URL?){
        return (self.image, self.imageURL)
    }

    
}
