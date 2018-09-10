//
//  DogCollectionVC.swift
//  iOS_mydogs
//
//  Created by Quang Nguyen on 9/10/18.
//  Copyright © 2018 Quang Nguyen. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class DogCollectionVC: UICollectionViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var dogs:[Dog] = []
    
    override func viewWillAppear(_ animated: Bool) {
        // Fetch all dogs
        fetchAllDogs()
        collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If a dog button is pressed, send the dog info
        if segue.identifier == "EditSegue" {
            print("PREPARING FOR EDIT SEGUE")
            let indexPath = sender as! IndexPath
            let editVC = segue.destination as! AddEditDeleteVC
            editVC.dogToEdit = dogs[indexPath.row]
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier, for: indexPath) as! DogCell
        print("\(cell.imageView)")
        // Configure the cell
        cell.renderWithData(from: dogs[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("GOIN TO DOG")
        performSegue(withIdentifier: "EditSegue", sender: indexPath)
    }
    
    
    func fetchAllDogs() {
        let dogRequest:NSFetchRequest<Dog> = Dog.fetchRequest()
        do {
            dogs = try context.fetch(dogRequest)
            // Here we can store the fetched data in an array
        } catch {
            print(error)
        }
    }


}
