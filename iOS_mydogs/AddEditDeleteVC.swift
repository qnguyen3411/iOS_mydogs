//
//  AddEditDeleteVC.swift
//  iOS_mydogs
//
//  Created by Quang Nguyen on 9/10/18.
//  Copyright © 2018 Quang Nguyen. All rights reserved.
//

import UIKit
import CoreData


class AddEditDeleteVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var favTreatField: UITextField!
    @IBOutlet weak var dogImageView: UIImageView!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var defaultImage:UIImage? = nil
    let picker = UIImagePickerController()
    
    var dogToEdit:Dog?
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func addDogButtonPressed(_ sender: UIButton) {
        guard addedDogHasImage() else { return }
        guard let name = nameField.text else { return }
        guard let color = colorField.text else { return }
        guard let favTreat = favTreatField.text else { return }
        
        let imageData:Data? = UIImageJPEGRepresentation(dogImageView.image!, 0.3)
        
        let dog = Dog(context: context)
        dog.name = name
        dog.color = color
        dog.favoriteTreat = favTreat
        dog.image = imageData
        saveContext()
        
        goBackToCollectionVC()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        guard isEditMode() else { return }
        context.delete(dogToEdit!)
        saveContext()
        goBackToCollectionVC()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultImage = dogImageView.image
        deleteButton.isHidden = true
        
        if isEditMode() {
            prefillFieldsWithData(from: dogToEdit!)
            deleteButton.isHidden = false
        }
        
        
        picker.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prefillFieldsWithData(from dog: Dog) {
        nameField.text = dog.name
        colorField.text = dog.color
        favTreatField.text = dog.favoriteTreat
        if let imageData = dog.image {
            dogImageView.image = UIImage(data: imageData)
        }
    }
    
    func addedDogHasImage() -> Bool {
        return !isEditMode() && dogImageView.image != defaultImage
    }
    
    func isEditMode() -> Bool {
        return dogToEdit != nil
    }
    
    func goBackToCollectionVC() {
        if let navController = self.navigationController,
            navController.viewControllers.count >= 2 {
            navController.popViewController(animated: true)
        }
    }
    
}

extension AddEditDeleteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        dogImageView.contentMode = .scaleAspectFit //3
        dogImageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
