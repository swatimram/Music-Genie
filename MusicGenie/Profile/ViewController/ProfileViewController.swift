//
//  ProfileViewController.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 21/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import CoreData

class ProfileViewController: BaseViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userInfoListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        
        profileImage?.layer.cornerRadius = profileImage.frame.height / 2
        profileImage?.layer.masksToBounds = true
        
        self.email.text =  UserModel.sharedInstance.email
        self.profileImage.image = UserModel.sharedInstance.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logout(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        UserModel.clearData()
    }
    
    @IBAction func updatePhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func updateinfo(_ sender: Any) {
        
        if let userMail = Auth.auth().currentUser?.email  {
            if let user = UserProfile.fetchSavedObject(withRequest: UserProfile.fetchRequest() , user: userMail) {
                MusicGenieCoreData.sharedInstance().getContext().delete(user)
                MusicGenieCoreData.sharedInstance().saveContext()
            }
        }
        
        let user = UserModel.sharedInstance
        
        let nameCell = userInfoListView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserInfoTableViewCell
        user.name = nameCell.value.text ?? ""
        let interestCell = userInfoListView.cellForRow(at: IndexPath(row: 1, section: 0)) as! UserInfoTableViewCell
        user.interest = interestCell.value.text ?? ""
        let bioCell = userInfoListView.cellForRow(at: IndexPath(row: 2, section: 0)) as! UserInfoTableViewCell
        user.bio = bioCell.value.text ?? ""
        let locationCell = userInfoListView.cellForRow(at: IndexPath(row: 3, section: 0)) as! UserInfoTableViewCell
        user.location = locationCell.value.text ?? ""
        
        user.email = Auth.auth().currentUser?.email ?? ""
        user.image = profileImage.image
        
        _ = UserProfile.saveUser(managedObjectContext: MusicGenieCoreData.sharedInstance().getContext(), userModel: user)
        MusicGenieCoreData.sharedInstance().saveContext()
        
        let alertController = UIAlertController(title: "Success", message: "Profile updated successfuly", preferredStyle: .alert)
       // let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel) { (_) in
            self.tabBarController?.selectedIndex = 0
        }
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController :  UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as! UserInfoTableViewCell
        switch indexPath.row {
        case 0 : cell.key.text = "Name"
                 cell.value.text = UserModel.sharedInstance.name
        case 1 : cell.key.text = "Interests"
                 cell.value.text = UserModel.sharedInstance.interest
        case 2 : cell.key.text = "Bio"
                 cell.value.text = UserModel.sharedInstance.bio
        case 3 : cell.key.text = "Location"
                 cell.value.text = UserModel.sharedInstance.location
        default: break
        }

        cell.selectionStyle = .none
        return cell
    }
    
}
extension ProfileViewController :  UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}


class UserModel: NSObject {
    
    static let sharedInstance = UserModel()
    
    var email = ""
    var image : UIImage?
    var name = ""
    var interest = ""
    var bio = ""
    var location = ""
    
    
    class func clearData() {
        UserModel.sharedInstance.email = ""
        UserModel.sharedInstance.image = nil
        UserModel.sharedInstance.name = ""
        UserModel.sharedInstance.interest = ""
        UserModel.sharedInstance.bio = ""
        UserModel.sharedInstance.location = ""
    }
}

