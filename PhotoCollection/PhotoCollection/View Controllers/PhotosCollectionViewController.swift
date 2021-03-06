//
//  PhotosCollectionViewController.swift
//  PhotoCollection
//
//  Created by Cameron Collins on 3/26/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    //Variables
    let photoController = PhotoController()
    let themeHelper = ThemeHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
        setTheme()
    }
    
    //Functions
    func setTheme() {
        if let myTheme = themeHelper.themePreference {
            switch myTheme {
                
            case Themes.dark.rawValue:
                collectionView.backgroundColor = .black
                
            case Themes.blue.rawValue:
                collectionView.backgroundColor = .blue
                
            default:
                break
            }
        }
        view.backgroundColor = .black
    }

    func updateView() {
        collectionView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            
            switch identifier {
            case "AddPhotoSegue":
                guard let destination = segue.destination as? PhotoDetailViewController else {
                    return
                }
                
                destination.themeHelper = themeHelper
                destination.photoController = photoController
                destination.delagate = self
                
            case "EditPhotoSegue":
                guard let destination = segue.destination as? PhotoDetailViewController else {
                    return
                }
                guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
                destination.themeHelper = themeHelper
                destination.photoController = photoController
                destination.photo = photoController.photos[indexPath.row]
                destination.delagate = self
            
            case "ThemeSegue":
                guard let destination = segue.destination as? ThemeSelectionViewController else {
                    return
                }
                
                destination.themeHelper = themeHelper
                
            default:
                break
            }
        }
    }
    

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoController.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
    
        guard let myCell = cell as? PhotosCollectionViewCell else {
            return cell
        }
        
        myCell.photo = photoController.photos[indexPath.item]
    
        return myCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
