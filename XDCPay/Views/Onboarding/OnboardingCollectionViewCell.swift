//
//  OnboardingCollectionViewCell.swift
//  XDCPay
//
//  Created by Chhaya Singh Parihar on 22/03/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImgLogo: UIImageView!
    @IBOutlet weak var slideMainImage: UIImageView!
    @IBOutlet weak var lblSlideTitle: UILabel!
    @IBOutlet weak var lblSlideDescription: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        
        slideImgLogo.image = slide.logo
        slideMainImage.image = slide.image
        lblSlideTitle.text = slide.title
        lblSlideDescription.text = slide.description
        
    }
}
