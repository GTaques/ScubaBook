//
//  DiveCreateView.swift
//  ScubaBook
//
//  Created by Gabriel Taques on 28/01/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI
import UIKit
import MapKit

enum SeaHealth {
    case good
    case meh
    case bad
}

struct ChosenImage {
    var id = UUID()
    var imageName = UIImage()
}

enum SourceType {
    case camera
    case library
}

struct DiveCreateView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var diveType: DiveType = .Scuba
    
    var diveTypes = ["Scuba", "Freedive", "Extended Range", "Rebreather"]
    @State private var selectedDiveType = 0
    
    @State var durationTime: String = ""
    @State var maxDepth: String = ""
    @State var diveDate: Date = Date()
    @State var diveSite: String = ""
    @State var animals: [String] = [""]
    @State var animal: String =  ""
    @State var health: SeaHealth
    @State var badSelected: Bool = false
    @State var mehSelected: Bool = false
    @State var goodSelected: Bool = false
    
    @State private var showingSheet = false
    @State var images: [ChosenImage] = []
    @State private var showingImagePicker = false
    @State var imageSelected = UIImage()
    @State var sourceType: SourceType
    
    @State private var showingMapView = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var mapViewInUse = true
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Cover Image")) {
                    Button(action: {
                        self.showingSheet = true
                    }) {
                        Text("Add Image")
                    }.actionSheet(isPresented: $showingSheet) {
                        ActionSheet(title: Text("Add Image"), buttons: [
                            ActionSheet.Button.default(Text("Take Photo"), action: {
                                self.sourceType = .camera
                                self.showingImagePicker = true
                            }),
                            ActionSheet.Button.default(Text("Photo Library"), action: {
                                self.sourceType = .library
                                self.showingImagePicker = true
                            }),
                            .cancel()
                            ])
                    }.sheet(isPresented: $showingImagePicker, content: {
                        ImagePickerView(isPresented: self.$showingImagePicker, images: self.$images, source: self.$sourceType)
                    })
                    List {
                        ForEach(images, id: \.id) { image in
                            HStack {
                                Image(uiImage: image.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .clipped()
                                .cornerRadius(4)
                                Text("Image").font(.footnote)
                            }
                            
                        }.onDelete(perform: delete)
                        .onMove(perform: move)
                    }
                }
                Section(header: Text("Details")) {
                    Picker(selection: $selectedDiveType, label: Text("Dive Type")) {
                        ForEach(0 ..< diveTypes.count) {
                            Text(self.diveTypes[$0])
                        }
                    }
                    TextField("Duration Time (m)", text: $durationTime).keyboardType(.numberPad)
                    TextField("Max Depth", text: $maxDepth).keyboardType(.numberPad)
                    
                    Button(action: {
                            self.showingMapView = true
                        print("Pins ja colocados: \(self.locations.count)")
                        }) {
                            Text(self.locations.count == 0 ? "Dive Site" : "Location Added")
                            
                        }.sheet(isPresented: $showingMapView, content: {
                            CustomMapSheet(centerCoordinate: self.$centerCoordinate, locations: self.$locations, showingMapView: self.$showingMapView, mapViewInUse: self.$mapViewInUse)
                            })
                    
                    DatePicker(
                        selection: $diveDate,
                        in: ...Date(),
                        displayedComponents: .date
                    ) {
                        Text("Date")
                    }
                }
                Section(header: Text("Wild Life")) {
                    ForEach(0..<self.animals.count, id: \.self) { a in
                        TextField("Animals", text: self.$animals[a])
                    }
                    Button(action: {
                        self.animals.append("")
                    }) {
                        Text("Add More")
                    }
                }
                Section(header: Text("Sea Health")) {
                    HStack(alignment: .center, spacing: 20) {
                        Spacer()
                        Button(action: {
                            self.badSelected = true
                            self.mehSelected = false
                            self.goodSelected = false
                        }) {
                            VStack {
                                Image("color_sad").resizable().frame(width: 50, height: 50, alignment: .center)
                                Text("Bad").font(.footnote)
                            }
                            
                        }.foregroundColor(self.badSelected ? .red : .black)
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Button(action: {
                            self.badSelected = false
                            self.mehSelected = true
                            self.goodSelected = false
                        } ) {
                            VStack {
                                Image("color_meh").resizable().frame(width: 50, height: 50, alignment: .center)
                                Text("Ok").font(.footnote)
                            }
                        }.foregroundColor(self.mehSelected ? .yellow : .black)
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Button(action: {
                            self.badSelected = false
                            self.mehSelected = false
                            self.goodSelected = true
                        }) {
                            VStack {
                                Image("color_happy").resizable().frame(width: 50, height: 50, alignment: .center)
                                Text("Good").font(.footnote)
                            }
                        }.foregroundColor(self.goodSelected ? .green : .black)
                        .buttonStyle(BorderlessButtonStyle())
                        Spacer()
                    }
                }
            }
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            }, trailing: Button(action: {
                let dive = DiveCard(durationTime: self.durationTime, maxDepth: self.maxDepth, diveType: self.diveType, diveDate: self.diveDate, diveNumber: Singleton.shared.dives.count + 1, diveSite: self.diveSite, images: self.images, locations: self.locations)
                Singleton.shared.dives.append(dive)
                self.presentationMode.wrappedValue.dismiss()
            }){
                  Text("Save")
            })
            .navigationBarTitle(Text("New Dive"), displayMode: .inline)
        }
    }
    
    func delete(at offsets: IndexSet) {
        images.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        let reversedSource = source.sorted()
        for index in reversedSource.reversed() {
            images.insert(images.remove(at: index), at: destination)
        }
    }
}

struct CustomMapSheet: View {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [MKPointAnnotation]
    @Binding var showingMapView: Bool
    @Binding var mapViewInUse: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                MapView(centerCoordinate: self.$centerCoordinate, annotations: self.locations)
            //                .edgesIgnoringSafeArea(.horizontal)
                Circle()
                            .fill(Color.blue)
                            .opacity(0.3)
                            .frame(width: 32, height: 32)
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    let newLocation = MKPointAnnotation()
                                    newLocation.coordinate = self.centerCoordinate
                                    self.locations.append(newLocation)
                                }) {
                                    Image(systemName: "plus")
                                }
                                .padding()
                                .background(Color.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                            }
                        }
            }.navigationBarTitle(Text("Add Location"), displayMode: .inline)
            .navigationBarItems(
            leading: Button(action: {
                self.locations = []
                self.showingMapView = false
            }) {
                Text("Cancel")
            }, trailing: Button(action: {
                self.mapViewInUse = false
                self.showingMapView = false
            }) {
                Text("Save")
            })
            
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var images: [ChosenImage]
    @Binding var source: SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        switch source {
        case .camera:
            controller.sourceType = .camera
        case .library:
            controller.sourceType = .photoLibrary
        }
        
        return controller
    }
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                print(selectedImage )
                self.parent.images.append(ChosenImage(id:UUID(), imageName:selectedImage))
                self.parent.isPresented = false
            }
            self.parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
}


struct DiveCreateView_Previews: PreviewProvider {
    
    static var previews: some View {
        DiveCreateView(health: .bad, sourceType: .camera)
    }
}
