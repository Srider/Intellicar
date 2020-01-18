//
//  ImageCell.swift
//  MovieApp
//
//  Created by Srikar on 06/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {
    
    @IBOutlet var lblMovieName:UILabel!
    @IBOutlet var lblMovieRating:UILabel!
    @IBOutlet var lblMovieTime:UILabel!
    @IBOutlet var lblGenre1:UILabel!
    @IBOutlet var lblGenre2:UILabel!
    @IBOutlet var lblHologram:UILabel!


//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        print("Awake called in ImageCell")
//        
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
