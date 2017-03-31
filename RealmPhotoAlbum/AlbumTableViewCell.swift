//
//  AlbumTableViewCell.swift
//  RealmPhotoAlbum
//
//  Created by Mijeong Jeon on 31/03/2017.
//  Copyright © 2017 Mijeong Jeon. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
   
    @IBOutlet weak var thumnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumnailView.layer.cornerRadius = 5.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        thumnailView.image = UIImage(named: "placeholder")
    }
}
