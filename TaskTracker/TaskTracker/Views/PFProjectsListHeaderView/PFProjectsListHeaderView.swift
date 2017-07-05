//
//  PFProjectListHeaderView.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 05.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit


class PFProjectsListHeaderView: UICollectionReusableView {

    
    // MARK: - Properties
    
    
    var nibView: UIView!
    
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var searchTextField: UITextField!


    // MARK: - Delegates
    
    
    weak var delegate: UITextFieldDelegate?
    
    
    // MARK: - Identifiers
    
    
    static var reuseIdentifier: String? {
        return String(describing: self).appending("Header")
    }
    
    
    // MARK: - Life Cycle
    

    func instanceFromNib() -> UIView {
        let nib = UINib(nibName: "PFProjectsListHeaderView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(searchTextField)
    }
    
    func setupView() {
        nibView = instanceFromNib()
        nibView.frame = bounds
        nibView.autoresizingMask = [.flexibleWidth,
                                    .flexibleHeight]
        addSubview(nibView)
        print(self.searchTextField)
    }
    
}
