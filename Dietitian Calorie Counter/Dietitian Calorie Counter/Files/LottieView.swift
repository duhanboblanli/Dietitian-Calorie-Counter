//
//  LottieView.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 15.10.2023.
//

//
//  LottieView.swift
//  Todo Mania
//
//  Created by Imran Sefat on 23/2/23.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    var name = "success"
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let lottieView = LottieAnimationView(name: name, bundle: Bundle.main)
        lottieView.loopMode = loopMode
        lottieView.play()
        
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieView)
        
        NSLayoutConstraint.activate([
            lottieView.heightAnchor.constraint(equalTo: view.heightAnchor),
            lottieView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            StaticBackground()
            LottieView(name: "coin-lottie.json")
                .frame(width: 155,height: 155)
        }
    }
}
