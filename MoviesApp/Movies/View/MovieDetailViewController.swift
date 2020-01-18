//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Srikar on 06/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit


class MovieDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var strMovieID:String?
    var dImageData:Data?
    
    var movieDetailPresenter:DetailViewToPresenterProtocol?
    @IBOutlet weak var objMovieImage: UIImageView!
    @IBOutlet weak var tblDetails: UITableView!

    var objMovieDetail:MovieDetail? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        if objMovieDetail == nil {
            Utilities.sharedInstance.addProgressIndicator(self.view)
            movieDetailPresenter?.fetchDetailForMovieWithID(strMovieID)
        }
    }

    func configureUI() {
        objMovieImage.image = UIImage.init(data:dImageData!)
        self.tblDetails?.layer.cornerRadius = 10.0
        self.tblDetails?.layer.masksToBounds = true
        self.tblDetails?.layer.borderWidth = 2.0
    }
    
    func reloadView()->Void {
        if self.objMovieDetail != nil {
            self.tblDetails?.dataSource = self
            self.tblDetails?.delegate = self
            
            if self.tblDetails.isHidden == true {
                self.tblDetails.isHidden = false
            }
            
            DispatchQueue.main.async {
                self.objMovieImage.image = UIImage.init(data:self.dImageData!)
                self.tblDetails?.reloadData()
            }
        }
    }
    
    //MARK:  UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0.0

        if indexPath.row == 0 {
            height = 100.0
        } else if indexPath.row == 1 {
            height = 110
        } else {
            height = 130.0
        }
        return height
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        
        var cell: UITableViewCell?
        
        if indexPath.row == 0 {
            cell = self.configureTitleCell(tableView, cellForRowAt: indexPath)
        } else if indexPath.row == 1 {
            cell = self.configureDescriptionCell(tableView, cellForRowAt: indexPath)
        } else {
            cell = self.configureDetailsCell(tableView, cellForRowAt: indexPath)
        }
        cell?.setNeedsDisplay()
        cell?.contentView.setNeedsDisplay()
        return cell!
    }
    
    func configureTitleCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        let cellIdentifier:String? = Constants.Cells.kTitleCell
        let cell:TitleCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath) as! TitleCell
        cell.lblMovieName.text = objMovieDetail?.title
        cell.lblMovieRating.text = objMovieDetail?.imdbRating
        cell.lblMovieTime.text = objMovieDetail?.runtime
        let arrStrings = objMovieDetail?.genre.components(separatedBy: ", ")
        cell.lblGenre1.text = arrStrings?[0]
        cell.lblGenre2.text = arrStrings?[1]
        
        cell.lblGenre1.layer.cornerRadius = 10.0
        cell.lblGenre1.layer.masksToBounds = true
        cell.lblGenre1.layer.borderWidth = 2.0
      
        cell.lblGenre2.layer.cornerRadius = 10.0
        cell.lblGenre2.layer.masksToBounds = true
        cell.lblGenre2.layer.borderWidth = 2.0
        
        cell.setNeedsDisplay()
        cell.contentView.setNeedsDisplay()
        return cell
    }
    
    func configureDescriptionCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        let cellIdentifier:String? = Constants.Cells.kDescriptionCell
        let cell:DescriptionCell! = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath) as! DescriptionCell)
        cell.txtView.text = objMovieDetail?.plot
        cell.setNeedsDisplay()
        cell.contentView.setNeedsDisplay()
        return cell!
    }
    
    func configureDetailsCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        let cellIdentifier:String? = Constants.Cells.kDetailsCell
        let cell:DetailsCell! = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath) as! DetailsCell)
        cell.lblCastingNames.text = objMovieDetail?.actors
        cell.lblDirectorName.text = objMovieDetail?.director
        cell.lblWriterName.text = objMovieDetail?.writer
        cell.setNeedsDisplay()
        cell.contentView.setNeedsDisplay()

        return cell!
    }
}

extension MovieDetailViewController:DetailPresenterToViewProtocol{
    func showMovieDetail(movieDetail: MovieDetail) {
        Utilities.sharedInstance.removeProgressIndicator()

        self.objMovieDetail = movieDetail
        self.reloadView()
    }
    
    func showError() {
        Utilities.sharedInstance.removeProgressIndicator()

        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Movie Detail", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorForMessage(error:String) {
        Utilities.sharedInstance.removeProgressIndicator()

        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


