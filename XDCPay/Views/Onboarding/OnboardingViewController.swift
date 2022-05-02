//
//  OnboardingViewController.swift
//  XDCPay
//
//  Created by Chhaya Singh Parihar on 21/03/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnGetStarted: UIButton!
    @IBOutlet var pageView: BorderedPageControl!
    
    var slides: [OnboardingSlide] = []
    var timer = Timer()
    var counter = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        slides = [OnboardingSlide(title: "Welcome to XDC Pay", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", logo: #imageLiteral(resourceName: "Logo"), image: #imageLiteral(resourceName: "Illustration1")), OnboardingSlide(title: "Manage your digital assets", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", logo: #imageLiteral(resourceName: "Logo"), image: #imageLiteral(resourceName: "Illustration 2"))]
        
        pageView.numberOfPages = slides.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.newImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func newImage() {
        
        if counter < slides.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
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
        if counter < slides.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
    
}

class BorderedPageControl: UIPageControl {

    var selectionColor: UIColor = AppColors.darkColor.color()
    
    override var currentPage: Int {
        didSet {
            updateBorderColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        currentPageIndicatorTintColor = selectionColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateBorderColor() {
        if #available(iOS 14.0, *)
        {
            let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 12.0, weight: .bold)
            let circleFill = UIImage(systemName: "circle.fill", withConfiguration: smallConfiguration)
            let circle = UIImage(systemName: "circle", withConfiguration: smallConfiguration)
            for index in 0..<numberOfPages
            {
                if index == currentPage
                {
                    setIndicatorImage(circleFill, forPage: index)
                }
                else
                {
                    setIndicatorImage(circle, forPage: index)
                }
            }
            pageIndicatorTintColor = selectionColor
        } else {
            subviews.enumerated().forEach { index, subview in
                if index != currentPage
                {
                    subview.layer.borderColor = selectionColor.cgColor
                    subview.layer.borderWidth = 1
                } else {
                    subview.layer.borderWidth = 0
                }
            }
        }
    }
}
