//
//  AppsSearchController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 17/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppsSearchController: UICollectionViewController {
    
    //MARK: - Properties
    private var appResults = [Result]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    //MARK:- Custom Initializers
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - System Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    private func setupCollectionView() {
        collectionView.addSubview(stateLabel)
        stateLabel.fillSuperview(padding: .init(top: 100.0, left: 50.0, bottom: 0.0, right: 50.0))
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.key)
    }
    
    //FIXME: Handle show correct message for none app match search text
    private func fetchITunesApps(with name: String) {
        AppsService.shared.fetchApps(with: AppsRouter.appSearch(name)) { (response) in
            DispatchQueue.main.async {
                switch response {
                case .success(let searchResults):
                    self.appResults = searchResults.results
                case .error(let error):
                    self.handleShowStateLabel(with: error.localizedDescription)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    private func handleShowStateLabel(with message: String = "Please search your app name...") {
        stateLabel.text = message
        stateLabel.isHidden = !appResults.isEmpty
    }
}


//MARK: Datasource Methods
extension AppsSearchController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        handleShowStateLabel()
     return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.key, for: indexPath) as! SearchResultCell
        cell.result = appResults[indexPath.item]
        return cell
    }
    
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 350.0)
    }
}

extension AppsSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //To avoid search throttling
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.fetchITunesApps(with: searchText)
        })
    }
}
