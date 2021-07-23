//
//  DetailView.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 21.07.2021.
//

import UIKit
import SDWebImage

@IBDesignable

class DetailView: UIView {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var posterImageView: UIImageView!
    @IBOutlet weak private var descriptionTextView: UITextView!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            configureView()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            configureView()
        }
    
    public func setUpView() {
        
    }
    
    }

    private extension DetailView {
        
        func loadViewFromNib(nibName: String) -> UIView? {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: nibName, bundle: bundle)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
        
        func configureView() {
            guard let view = self.loadViewFromNib(nibName: "DetailView") else {return}
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
