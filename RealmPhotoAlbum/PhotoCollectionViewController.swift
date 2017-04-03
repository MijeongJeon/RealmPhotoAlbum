//
//  PhotoCollectionViewController.swift
//  RealmPhotoAlbum
//
//  Created by Mijeong Jeon on 31/03/2017.
//  Copyright © 2017 Mijeong Jeon. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "PhotoCell"

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    var selectedAlbum: Album!
    
    private var realm: Realm!
    private var photos: Results<Photo>!
    private var token: NotificationToken!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Realm init
        do {
            realm = try Realm()
        } catch {
            print("\(error)")
        }
        // get Photo objects in selectedAlbum
        photos = selectedAlbum.photos.sorted(byKeyPath: "saveDate", ascending: false)
        // add notification block
        token = photos.addNotificationBlock({ (change) in
            self.collectionView?.reloadData()
        })
        
        navigationItem.title = selectedAlbum.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        // set saved image
        if let image = UIImage(data: photos[indexPath.item].imageData) {
            cell.imageView.image = image
        }
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDeleteAlert(indexPath: indexPath)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemLength = (collectionView.frame.size.width - 15) / 4
        return CGSize(width: itemLength, height: itemLength)
    }
    
    // MARK: UIImagePickerController
    @IBAction func showImagePicker(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // save selected photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let newPhoto = Photo()
        newPhoto.imageData = UIImageJPEGRepresentation(selectedImage, 0.01)!
        // realm write
        do {
            try realm.write {
                self.selectedAlbum.photos.append(newPhoto)
            }
        } catch {
            print("\(error)")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showDeleteAlert(indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Delete", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (deleteAction) in
            // realm delete
            do {
                try self.realm.write {
                    self.realm.delete(self.photos[indexPath.item])
                }
            } catch {
                print("\(error)")
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
