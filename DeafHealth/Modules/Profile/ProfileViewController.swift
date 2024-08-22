//
//  ProfileViewController.swift
//  DeafHealth
//
//  Created by Anthony on 22/08/24.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var profileImageView: ProfileImageView!
    var cameraIconView: UIImageView!
    var nameLabel: UILabel!
    var nameTextField: UITextField!
    var ageLabel: UILabel!
    var ageTextField: UITextField!
    var genderLabel: UILabel!
    var genderSegmentedControl: UISegmentedControl!
    var allergiesLabel: UILabel!
    var allergiesTextField: UITextField!
    var lanjutkanButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadUserData()
    }

    private func setupUI() {
        view.backgroundColor = .white

        // Profile Image
        profileImageView = ProfileImageView()
        profileImageView.backgroundColor = UIColor(named: "grey-med")
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)

        // Camera Icon
        cameraIconView = UIImageView(image: UIImage(systemName: "camera.fill"))
        cameraIconView.translatesAutoresizingMaskIntoConstraints = false
        cameraIconView.backgroundColor = UIColor(named: "grey-med")
        cameraIconView.layer.cornerRadius = 20
        cameraIconView.tintColor = .black
        cameraIconView.contentMode = .center
        cameraIconView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        cameraIconView.addGestureRecognizer(tapGesture)
        view.addSubview(cameraIconView)

        // Name Label and TextField
        nameLabel = createRequiredLabel(text: "Nama")
        view.addSubview(nameLabel)
        nameTextField = createTextField(placeholder: "Name")
        view.addSubview(nameTextField)

        // Age Label and TextField
        ageLabel = createRequiredLabel(text: "Umur")
        view.addSubview(ageLabel)
        ageTextField = createTextField(placeholder: "Age")
        view.addSubview(ageTextField)

        // Gender Label and Segmented Control
        genderLabel = createRequiredLabel(text: "Jenis Kelamin")
        view.addSubview(genderLabel)
        genderSegmentedControl = UISegmentedControl(items: ["Male", "Female"])
        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderSegmentedControl)

        // Allergies Label and TextField
        allergiesLabel = createLabel(text: "Daftar Alergi Obat")
        view.addSubview(allergiesLabel)
        allergiesTextField = createTextField(placeholder: "Allergies (comma-separated)")
        view.addSubview(allergiesTextField)

        // Lanjutkan Button
        lanjutkanButton = UIButton(type: .system)
        lanjutkanButton.setTitle(AppLabel.saveButton, for: .normal)
        lanjutkanButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        lanjutkanButton.setTitleColor(.white, for: .normal)
        lanjutkanButton.backgroundColor = UIColor(red: 0.25, green: 0.48, blue: 0.68, alpha: 1.0)
        lanjutkanButton.layer.cornerRadius = 25
        lanjutkanButton.translatesAutoresizingMaskIntoConstraints = false
        lanjutkanButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
        view.addSubview(lanjutkanButton)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),

            cameraIconView.widthAnchor.constraint(equalToConstant: 40),
            cameraIconView.heightAnchor.constraint(equalToConstant: 40),
            cameraIconView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            cameraIconView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            ageLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            ageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 5),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            genderLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            genderSegmentedControl.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 5),
            genderSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            allergiesLabel.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 20),
            allergiesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            allergiesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            allergiesTextField.topAnchor.constraint(equalTo: allergiesLabel.bottomAnchor, constant: 5),
            allergiesTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            allergiesTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            lanjutkanButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            lanjutkanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lanjutkanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lanjutkanButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createRequiredLabel(text: String) -> UILabel {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ])
        attributedText.append(NSAttributedString(string: " *", attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor.red
        ]))
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }

    private func loadUserData() {
        if let userData = LocalDataSource.shared.fetchUserData() {
            nameTextField.text = userData.name
            ageTextField.text = userData.age
            genderSegmentedControl.selectedSegmentIndex = userData.gender == .male ? 0 : 1
            allergiesTextField.text = combineAllergies(userData)

            // Load the profile image from data
            if let imageData = userData.profileImageData {
                profileImageView.image = UIImage(data: imageData)
            } else {
                profileImageView.image = UIImage(named: "defaultProfileImage")  // Load default image if none is saved
            }
        }
    }

    private func combineAllergies(_ userData: UserData) -> String {
        let allergies = [userData.foodAllergy, userData.drugAllergy, userData.conditionAllergy]
        return allergies.compactMap { $0 }.joined(separator: ", ")
    }

    @objc private func changeProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func saveProfile() {
        guard let name = nameTextField.text, !name.isEmpty,
              let age = ageTextField.text, !age.isEmpty else {
            print("Name or Age field is empty")
            return
        }

        let gender: Gender = genderSegmentedControl.selectedSegmentIndex == 0 ? .male : .female

        let allergies = allergiesTextField.text?.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } ?? []

        let foodAllergy = allergies.count > 0 ? allergies[0] : nil
        let drugAllergy = allergies.count > 1 ? allergies[1] : nil
        let conditionAllergy = allergies.count > 2 ? allergies[2] : nil

        // Convert the profile image to Data
        let profileImageData = profileImageView.image?.jpegData(compressionQuality: 0.8)

        LocalDataSource.shared.saveUserData(
            name: name,
            age: age,
            gender: gender,
            foodAllergy: foodAllergy,
            drugAllergy: drugAllergy,
            conditionAllergy: conditionAllergy,
            profileImageData: profileImageData  // Save the image data
        )
        
        navigationController?.popViewController(animated: true)
    }


    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

