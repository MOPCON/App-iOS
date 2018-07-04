//
//  CommunityViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController {
    
    @IBOutlet weak var communityImageContainerView: UIView!
    @IBOutlet weak var volunteerContainerView: UIView!
    
    @IBOutlet weak var mainGroupButton: CustomSelectedButton!
    @IBOutlet weak var volunteerButton: CustomSelectedButton!
    
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mainGroupAction(_ sender: UIButton) {
        changeButtonColor(beTappedButton: mainGroupButton, notSelectedButton: volunteerButton)
        communityImageContainerView.isHidden = false
        volunteerContainerView.isHidden = true
    }
    
    @IBAction func volunteerAction(_ sender: UIButton) {
        changeButtonColor(beTappedButton: volunteerButton, notSelectedButton: mainGroupButton)
        communityImageContainerView.isHidden = true
        volunteerContainerView.isHidden = false
    }
    
    func changeButtonColor(beTappedButton:CustomSelectedButton, notSelectedButton:CustomSelectedButton){
          beTappedButton.backgroundColor = UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 0.2)
          beTappedButton.setTitleColor(UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 1), for: .normal)
          beTappedButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
          notSelectedButton.backgroundColor = UIColor.clear
          notSelectedButton.setTitleColor(UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 0.5), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        volunteerContainerView.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIDManager.performCommunityContainerView{
            guard let communityImageVC = segue.destination as? CommunityImageViewController else {return}
            communityImageVC.delegate = self
        }
        if segue.identifier == SegueIDManager.performCommunityDetail{
            guard let commnunityDetailVC = segue.destination as? ComminityDetailViewController else {return}
            guard let imageSender = sender as? String else {return}
            commnunityDetailVC.imageNameFromPreviousPage = imageSender
        }
    }

}
extension CommunityViewController: CollectionViewItemDidSelected{
    func collectionViewItemDidSelected(index: IndexPath, imageName: String) {
        performSegue(withIdentifier: SegueIDManager.performCommunityDetail, sender: imageName)
    }
}
