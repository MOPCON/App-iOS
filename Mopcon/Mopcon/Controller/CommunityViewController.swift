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
    
    
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
