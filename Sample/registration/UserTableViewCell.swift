//
//  UserTableViewCell.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 25/2/25.
//

import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func userTableViewCell(_ cell: UserTableViewCell, didTapEmailFor user: User)
}

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtEmail: UILabel!
    static let identifier = "UserTableViewCell"
    weak var delegate: UserTableViewCellDelegate?
    private var user: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupEmailLabelTapGesture()
    }
    
    private func setupEmailLabelTapGesture() {
            txtEmail.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emailLabelTapped))
            tapGesture.numberOfTapsRequired = 1
            txtEmail.addGestureRecognizer(tapGesture)
    }
    
    func configure(with user: User) {
            self.user = user
        txtEmail.text = user.email
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
    
    @objc private func emailLabelTapped() {
        
        print("Email label was tapped!")
            
        guard let user = user else {
            return
        }
        delegate?.userTableViewCell(self, didTapEmailFor: user)
        
        }
}
