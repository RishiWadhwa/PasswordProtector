//
//  PasswordTableViewCell.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/25/21.
//

import UIKit

class PasswordTableViewCell: UITableViewCell
{
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
