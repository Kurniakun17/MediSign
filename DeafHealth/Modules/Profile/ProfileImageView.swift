//
//  ProfileImageView.swift
//  DeafHealth
//
//  Created by Anthony on 22/08/24.
//

import UIKit

class ProfileImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    init() {
        super.init(frame: .zero) // Initialize with a zero frame
        setupView()
    }

    private func setupView() {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = 60 // Half of width/height to make it circular
        self.backgroundColor = .gray // Set the background color to gray
        self.image = UIImage(named: "defaultProfileImage") // Set a default gray image if needed
        self.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func changeProfileImage() {
        // Implement image picker or other logic to change profile image
        print("Change Profile Image")
    }
}
