//
//  ImagePickerRepresentable.swift
//  ScubaBook
//
//  Created by Gabriel Taques on 29/01/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import UIKit

//struct ImagePickerView: UIViewControllerRepresentable {
//    
//    @Binding var isPresented: Bool
////    @Binding var selectedImage: UIImage
//    @Binding var images: [ChosenImage]
//    @Binding var source: SourceType
//    
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIViewController {
//        let controller = UIImagePickerController()
//        controller.delegate = context.coordinator
//        switch source {
//        case .camera:
//            controller.sourceType = .camera
//        case .library:
//            controller.sourceType = .photoLibrary
//        }
//        
//        return controller
//    }
//    
//    func makeCoordinator() -> ImagePickerView.Coordinator {
//        return Coordinator(parent: self)
//    }
//    
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        
//        let parent: ImagePickerView
//        init(parent: ImagePickerView) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let selectedImage = info[.originalImage] as? UIImage {
//                print(selectedImage )
//                self.parent.images.append(ChosenImage(id:UUID(), imageName:selectedImage))
////                self.parent.selectedImage = selectedImage
//                self.parent.isPresented = false
//            }
//            self.parent.isPresented = false
//        }
//        
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            self.parent.isPresented = false
//        }
//    }
//    
//    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
//        
//    }
//    
//    
//}
