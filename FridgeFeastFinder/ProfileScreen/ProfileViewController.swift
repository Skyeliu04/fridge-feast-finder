//
//  ProfileViewController.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 11/28/23.
//

import UIKit
import PhotosUI
import FirebaseAuth
import Firebase
import FirebaseStorage
import SDWebImage

class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    //MARK: variable to store the picked Image...
    var pickedImage:UIImage?
    let notificationCenter = NotificationCenter.default
    
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "power"), style: .plain, target: self, action: #selector(onLogoutTapped))
        self.showActivityIndicator()
        fetchUserDataAndUpdateProfile()
        profileView.buttonTakePhoto.menu = getMenuImagePicker()
        
    }
    
    @objc func onLogoutTapped(){
        logoutFirebase()
    }
    
    func fetchUserDataAndUpdateProfile() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated.")
            return
        }
        
        // Reference to the user's document in Firestore
        let userDocumentRef = Firestore.firestore().collection("users").document(uid)
        
        // Fetch user data
        userDocumentRef.getDocument { document, error in
            if let error = error {
                print("Error fetching user data from Firestore: \(error.localizedDescription)")
                return
            }
            
            // Update the profile view with user data
            if let document = document, document.exists {
                if let name = document["name"] as? String,
                   let email = document["email"] as? String,
                   let imageURLString = document["imageURL"] as? String,
                   let imageURL = URL(string: imageURLString) {
                    
                    // Update the UI with user data
                    self.profileView.labelName.text = name
                    self.profileView.labelEmail.text = email
                    self.profileView.buttonTakePhoto.tintColor = .clear
                    
                    SDWebImageManager.shared.loadImage(with: imageURL, options: [], progress: nil) { (image, _, error, _, _, _) in
                        if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                        } else if let image = image {
                            // Set the downloaded image to the button
                            self.profileView.buttonTakePhoto.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                            self.pickedImage = image
                        }
                    }
                    self.hideActivityIndicator()
                }
            } else {
                let email = Auth.auth().currentUser?.email
                self.profileView.labelName.text = self.getPrefix(email: email ?? "test@gmail.com")
                self.profileView.labelEmail.text = email
                self.hideActivityIndicator()
            }
        }
    }
        
        
        func logoutFirebase() {
            print("triggered")
            let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
            logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
//                    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                    // Call the function to reset the window's rootViewController
                    // sceneDelegate.showMainApp()
                    self.notificationCenter.post(
                                    name: Notification.Name("textFromSecondScreen"),
                                    object: nil)
                    print("notification sent")
                }catch{
                    self.showErrorAlert(message: error.localizedDescription)
                    print("Error occured!")
                }
            })
            )
            logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(logoutAlert, animated: true)
        }
        
        func getMenuImagePicker() -> UIMenu{
            let menuItems = [
                UIAction(title: "Camera",handler: {(_) in
                    self.pickUsingCamera()
                }),
                UIAction(title: "Gallery",handler: {(_) in
                    self.pickPhotoFromGallery()
                })
            ]
            
            return UIMenu(title: "Select source", children: menuItems)
        }
        
        //MARK: take Photo using Camera...
        func pickUsingCamera(){
            let cameraController = UIImagePickerController()
            cameraController.sourceType = .camera
            cameraController.allowsEditing = true
            cameraController.delegate = self
            present(cameraController, animated: true)
        }
        
        //MARK: pick Photo using Gallery...
        func pickPhotoFromGallery(){
            var configuration = PHPickerConfiguration()
            configuration.filter = PHPickerFilter.any(of: [.images])
            configuration.selectionLimit = 1
            
            let photoPicker = PHPickerViewController(configuration: configuration)
            
            photoPicker.delegate = self
            present(photoPicker, animated: true, completion: nil)
        }
        
        func getPrefix(email: String) -> String {
            let components = email.components(separatedBy: "@")
            if components.count > 1 {
                return components[0]
            } else {
                return email
            }
        }
    
    func showErrorAlert(message: String?){
        let alert = UIAlertController(
            title: "Error!", message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        alert.present(alert, animated: true)
    }
        
        
        func saveProfileImageToFirestore(image: UIImage) {
            // Get the user's UID and email
            guard let uid = Auth.auth().currentUser?.uid,
                  let email = Auth.auth().currentUser?.email else {
                print("Error: User not authenticated.")
                return
            }
            
            let name = getPrefix(email: email)
            
            // Generate a unique filename for the image in Firebase Storage
            let filename = "\(UUID().uuidString).jpg"
            let storageRef = Storage.storage().reference().child(filename)
            
            // Convert the selected image to data
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                print("Error: Failed to convert image to data.")
                return
            }
            
            // Upload the image to Firebase Storage
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image to Firebase Storage: \(error.localizedDescription)")
                    return
                }
                
                // Get the download URL for the uploaded image
                storageRef.downloadURL { url, error in
                    guard let downloadURL = url else {
                        print("Error retrieving download URL: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    
                    // Prepare the data to be saved in Firestore
                    let userData: [String: Any] = [
                        "uid": uid,
                        "name": name,
                        "email": email,
                        "imageURL": downloadURL.absoluteString
                    ]
                    
                    // Save the user data to Firestore
                    Firestore.firestore().collection("users").document(uid).setData(userData, merge: true) { error in
                        if let error = error {
                            print("Error saving user data to Firestore: \(error.localizedDescription)")
                        } else {
                            print("User data saved successfully!")
                        }
                    }
                }
            }
        }
    
        
        
        
    }
    
    
    // MARK: adopting required protocols for PHPicker...
    extension ProfileViewController:PHPickerViewControllerDelegate {
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            dismiss(animated: true)
            
            print(results)
            
            let itemprovider = results.map(\.itemProvider)
            
            for item in itemprovider{
                if item.canLoadObject(ofClass: UIImage.self){
                    item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                        DispatchQueue.main.async{
                            if let uwImage = image as? UIImage{
                                self.profileView.buttonTakePhoto.setImage(
                                    uwImage.withRenderingMode(.alwaysOriginal),
                                    for: .normal
                                )
                                self.pickedImage = uwImage
                                print("called")
                                if let pickedImage = self.pickedImage {
                                    self.saveProfileImageToFirestore(image: pickedImage)
                                }
                            }
                        }
                    })
                }
            }
        }
    }
    
    //MARK: adopting required protocols for UIImagePicker...
    extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            
            if let image = info[.editedImage] as? UIImage{
                self.profileView.buttonTakePhoto.setImage(
                    image.withRenderingMode(.alwaysOriginal),
                    for: .normal
                )
                self.pickedImage = image
                if let pickedImage = self.pickedImage {
                    self.saveProfileImageToFirestore(image: pickedImage)
                }
                print("called")
                
            }else{
                // Do your thing for No image loaded...
            }
        }
    }
    
