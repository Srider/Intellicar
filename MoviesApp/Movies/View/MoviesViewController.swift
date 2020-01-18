//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MoviesViewController: UIViewController {
    
    var moviePresenter:ViewToPresenterProtocol?
    
    @IBOutlet weak var objMoviesListView: UICollectionView!
    @IBOutlet weak var objSearchBar: UISearchBar!
    @IBOutlet weak var lblNoMovies: UILabel!
    
    var arrMovies:Array<Movie> = Array()
    var objSelectedMovie:Movie? = nil
    //    var searchString:String! = "sky"
    var searchString:String! = String.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.sharedInstance.addProgressIndicator(self.view)
        moviePresenter?.fetchMoviesBasedOnSelection(self.searchString)
    }
    
    func reloadView()->Void {
        if self.arrMovies.count > 0 {
            self.objMoviesListView?.dataSource = self
            self.objMoviesListView?.delegate = self
            self.objMoviesListView?.prefetchDataSource = self
            if self.objMoviesListView?.isHidden == true {
                self.objMoviesListView?.isHidden = false
            }
            
            self.lblNoMovies.isHidden = true
            
            DispatchQueue.main.async {
                self.objMoviesListView?.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetailViewController" {
            let objDetailVC:MovieDetailViewController! = (segue.destination as! MovieDetailViewController)
            objDetailVC.strMovieID = self.objSelectedMovie?.imdbID
            objDetailVC.dImageData = self.objSelectedMovie?.dImageData
        }
    }
}

extension MoviesViewController:PresenterToViewProtocol{
    func showMovies(movieArray: Array<Movie>) {
        Utilities.sharedInstance.removeProgressIndicator()
        self.arrMovies = movieArray
        self.reloadView()
    }
    
    func showError() {
        Utilities.sharedInstance.removeProgressIndicator()
        self.objMoviesListView?.isHidden = true
        if self.lblNoMovies.isHidden == true {
            self.lblNoMovies.isHidden = false
        }
        self.arrMovies.removeAll()
    }
    
    func showErrorForMessage(error:String) {
        self.objMoviesListView?.isHidden = true
        self.arrMovies.removeAll()
        
        if self.lblNoMovies.isHidden == true {
            self.lblNoMovies.isHidden = false
        }
        
        self.lblNoMovies.text = error
        Utilities.sharedInstance.removeProgressIndicator()
    }
}

extension MoviesViewController:UICollectionViewDataSource {
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var items:Int! = arrMovies.count
        return items
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        var cell:UICollectionViewCell? = nil
        let objMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.kMovieCell, for: indexPath as IndexPath) as! MovieInfoCell
        let objMovie = self.arrMovies[indexPath.item]
        objMovieCell.lblMovieName?.text = objMovie.title
        objMovieCell.imgMovieImage?.layer.cornerRadius = 5.0
        objMovieCell.imgMovieImage?.layer.masksToBounds = true
        objMovieCell.imgMovieImage?.layer.borderWidth = 2.0
        objMovieCell.lblMovieYear?.text = objMovie.year
        if objMovie.dImageData != nil {
            objMovieCell.imgMovieImage?.image = UIImage(data:objMovie.dImageData!)
        } else {
            objMovieCell.imgMovieImage?.image = UIImage(named: "no-image")
        }
        cell = objMovieCell as UICollectionViewCell
        cell?.contentView.setNeedsDisplay()
        return cell!
    }
}


extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insets:UIEdgeInsets! = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        insets.top = 5
        insets.bottom = 5
        insets.left = 5
        insets.right = 5
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // your code here
        var size:CGSize! = CGSize.init(width: 0, height: 0)
        size.height = 185
        size.width = (self.view.frame.size.width)/4.5
        return size
    }
}

extension MoviesViewController:UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch: \(indexPaths)")
//        for indexPath in indexPaths {
//            let model:Movie! = arrMovies[indexPath.row] as! Movie
//            DispatchQueue.main.async {
//                model.dImageData = try? Data(contentsOf: URL.init(string: model!.poster)!)
//            }
//        }
    }
}

extension MoviesViewController:UICollectionViewDelegate {
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        self.objSelectedMovie = self.arrMovies[indexPath.item]
        self.navigationController?.pushViewController(MoviesDetailRouter.createMovieDetailModule(self.objSelectedMovie!.imdbID, imgData: self.objSelectedMovie!.dImageData!), animated: false)
    }
}


extension MoviesViewController:UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        /* prepare search text based on user's input */
        filterSearchText(text)
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /* Resign keyboard when return key is clicked */
        objSearchBar?.resignFirstResponder()
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       /* Resign keyboard when return key is clicked */
        objSearchBar?.resignFirstResponder()
    }

    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        /* Resign keyboard when return key is clicked */
        objSearchBar?.resignFirstResponder()
    }


    //MARK:  filterSearchText(_ string:String!)
    func filterSearchText(_ string:String!) {
        if string.isEmpty {
            if !(searchString.isEmpty) {
                    /* If String is Empty and search String is not Empty, then delete character from Search string  */
                    searchString.removeLast()
                }
        } else {
            /* otherwise append character to Search string  */
            searchString.append(string)
        }

        if !searchString.isEmpty {
            searchString = searchString.replacingOccurrences(of: "\n", with: "")
            /* If String is Not Empty then, add request to the queue  */
            Utilities.sharedInstance.addProgressIndicator(self.view)
            moviePresenter?.fetchMoviesBasedOnSelection(self.searchString)
        } else {

            self.objSearchBar?.text = ""

            /* Create Alert Action */
            let action:UIAlertAction! = UIAlertAction.init(title: Constants.Alerts.kOkayButtontitle, style: UIAlertAction.Style.default) { (UIAlertAction) in
                //Handle your yes please button action here
            }

            /* Show Alert */
            Utilities.sharedInstance.showAlert(Constants.Alerts.SEARCH_ALERT, message: Constants.Alerts.kEmptySearchMessage, style:UIAlertController.Style.alert, action: action, on:self)


            /* If String is Empty then, refresh datasource and relaod table  */
            self.objMoviesListView?.isHidden = false
            self.lblNoMovies?.isHidden = true
            self.reloadView()
        }
    }

}
