//
//  GyphController.swift
//  whitespectre-ios-challenge
//
//  Created by Mac on 5/29/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import SwiftyGif

class GifViewController: UIViewController {
    
    // MARK: - IBOutlets and variables
    
    @IBOutlet weak var viewModel: ViewModel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var offSet = 0
    var query = ""
    var isSearch = false
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        loadData()        
    }
    
    func loadData() {
        
        viewModel.getGifs(isSearch: isSearch, query: query, offSet: offSet) {
            self.collectionView.reloadData()
        }
    }
}

extension GifViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionView DataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsToDisplay(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = GifCollectionViewCell.cellForCollectionView(collectionView: collectionView, indexPath: indexPath)
        cell.glyphNameLabel.text = viewModel.glyphTiltle(for: indexPath)
        
        if let url = viewModel.glyphUrl(for: indexPath) {
            cell.glphyImageView.setGifFromURL(url)
        }
        
        return cell
    }
    
    // MARK: - UIScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {

            if viewModel.totalPaginationCount() > viewModel.numberOfItemsToDisplay(in: 0) {
                offSet += 20
                loadData()
            }
        }
    }
    
    // MARK: UICollectionView DelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width/2) - 20 , height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 15, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
}

extension GifViewController: UISearchBarDelegate {
    
    // MARK: - UISearchBarDelegate Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if searchBar.text != "" {
            isSearch = true
            query = searchBar.text!
            offSet = 0
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            loadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
            isSearch = false
            query = ""
            offSet = 0
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            loadData()
        }
    }
}


