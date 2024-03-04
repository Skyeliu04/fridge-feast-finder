//
//  UserRecipeUploadViewController.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 12/2/23.
//

import UIKit
import PhotosUI
import FirebaseAuth
import Firebase
import FirebaseStorage
import SDWebImage

class UserRecipeUploadViewController: UIViewController {
    
    let userRecipeUploadView = UserRecipeUploadView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    var pickedImage:UIImage?
    
    override func loadView() {
        view = userRecipeUploadView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userRecipeUploadView.uploadButton.addTarget(self, action: #selector(onUploadButtonTapped), for: .touchUpInside)
        userRecipeUploadView.imageView.menu = getMenuImagePicker()
        hideKeyboardOnTapOutside()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // Reset the image and text field to default values
            userRecipeUploadView.imageView.setImage(UIImage(systemName: "camera"), for: .normal)
            userRecipeUploadView.commentTextField.text = ""

            // Ensure pickedImage is nil or set it to your default image if needed
            pickedImage = UIImage(systemName: "camera")
        }
    
    //MARK: hide keyboard logic...
    func hideKeyboardOnTapOutside(){
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    @objc func onUploadButtonTapped(){
        guard let pickedImage = self.pickedImage else {
                // Show a warning because the image is empty
                showAlert(message: "Please select an image.")
                return
            }

            guard let comment = userRecipeUploadView.commentTextField.text, !comment.isEmpty else {
                // Show a warning because the comment is empty
                showAlert(message: "Please enter a comment.")
                return
            }
        
        self.showActivityIndicator()
        saveRecipeToFirestore(image: pickedImage)
        
    }
    
    func saveRecipeToFirestore(image: UIImage) {
        // Get the user's UID and email
        
        let uuid = UUID()
        guard let uid = Auth.auth().currentUser?.uid,
              let email = Auth.auth().currentUser?.email else {
            print("Error: User not authenticated.")
            return
        }
        
        
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
                
                let comment = self.userRecipeUploadView.commentTextField.text?.description
                // Prepare the data to be saved in Firestore
                let recipeData: [String: Any] = [
                    "email": email,
                    "comment": comment!,
                    "imageUrl": downloadURL.absoluteString
                ]
                
                // Save the user data to Firestore
                Firestore.firestore().collection("Post").document(uuid.uuidString).setData(recipeData, merge: true) { error in
                    if let error = error {
                        print("Error saving recipe data to Firestore: \(error.localizedDescription)")
                    } else {
                        print("recipe data saved successfully!")
                        self.hideActivityIndicator()
                        
                        // Access the tab bar controller and set the selected index to the desired tab
                        if let tabBarController = self.tabBarController {
                            tabBarController.selectedIndex = 3 // Set the index of the "User Recipes" tab
                        }
                    }
                }
            }
        }
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
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
    
    
}

// MARK: adopting required protocols for PHPicker...
extension UserRecipeUploadViewController:PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.userRecipeUploadView.imageView.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}

//MARK: adopting required protocols for UIImagePicker...
extension UserRecipeUploadViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.userRecipeUploadView.imageView.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}
