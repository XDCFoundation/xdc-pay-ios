//
//  OnboardingViewController.swift
//  XDCPay
//
//  Created by Chhaya Singh Parihar on 21/03/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnGetStarted: UIButton!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        slides = [OnboardingSlide(title: "Welcome to XDC Pay", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", logo: #imageLiteral(resourceName: "Logo"), image: #imageLiteral(resourceName: "Illustration1")), OnboardingSlide(title: "Manage your digital assets", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", logo: #imageLiteral(resourceName: "Logo"), image: #imageLiteral(resourceName: "Illustration 2"))]
    }
    @IBAction func getStartedClicked(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
       // controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
        
    }
    

}
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        pageControl.currentPage = currentPage
    }
    
}
