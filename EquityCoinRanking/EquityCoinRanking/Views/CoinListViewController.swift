//
//  ViewController.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import UIKit
import SwiftUI
import Combine

class CoinListViewController: UIViewController {
    @IBOutlet weak var tblCoin: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var btn24H: UIButton!
    
    private var viewModel: CoinListViewModel!
    private var favoritesManager: FavoritesManager!
    private var cancellables = Set<AnyCancellable>()
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coin Lists"
        navigationController?.navigationBar.tintColor = .black
        favoritesManager = FavoritesManager()
        viewModel = CoinListViewModel(favoritesManager: favoritesManager)
        
        setupUI()
        bindViewModel()
        loadData()
    }
    
    private func setupUI() {
        tblCoin.register(CoinListCell.nib(), forCellReuseIdentifier: String(describing: CoinListCell.self))
        refreshControl.attributedTitle = NSAttributedString(string: CommonMessage.pullToRefresh.rawValue)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tblCoin.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        if viewModel.showFavoritesOnly {
            self.refreshControl.endRefreshing()
            return
        }
        viewModel.fetchCoins(refresh: true)
    }
    
    private func loadData() {
        viewModel.fetchCoins()
    }
    
    private func bindViewModel() {
        viewModel.$filteredCoins
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tblCoin.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if !isLoading {
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let errorMessage = errorMessage {
                    self?.showError(errorMessage)
                }
            }
            .store(in: &cancellables)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    

}

// MARK: - All Button Actions
extension CoinListViewController {
    @IBAction func didTapOnCoinButton(_ sender: Any) {
        viewModel.toggleFavoriteFilter()
        let newTitle = viewModel.showFavoritesOnly ? "Favorites" : "All"
        btnAll.setTitle(newTitle, for: .normal)
    }
    
    
    @IBAction func didTapOnPriceButton(_ sender: Any) {
        btnPrice.isSelected.toggle()
        if btnPrice.isSelected {
            viewModel.fetchCoins(refresh: true, coinType: .price)
        } else {
            viewModel.fetchCoins(refresh: true)
        }
        btnPrice.setImage(UIImage(systemName: btnPrice.isSelected ? "chevron.up" : "chevron.down"), for: .normal)
    }
    
    @IBAction func didTapOn24HButton(_ sender: Any) {
        let alert = UIAlertController(title: "Select Time Range", message: nil, preferredStyle: .actionSheet)
        let options: [TimeFilter] = [.h1,.h3,.h12,.h24,.d7,.d30,.m3,.y1,.y3,.y5]
        options.forEach { option in
            let action = UIAlertAction(title: option.rawValue, style: .default) { _ in
                self.viewModel.selectedTimeFilter = option
                self.viewModel.fetchCoins(refresh: true, coinType: .period(option))
                self.btn24H.setTitle(option.rawValue, for: .normal)
            }
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CoinListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CoinListCell.self), for: indexPath) as! CoinListCell
        let coin = viewModel.filteredCoins[indexPath.row]
        cell.configure(with: coin, isFavorite: favoritesManager.isFavorite(coin))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = viewModel.filteredCoins[indexPath.row]
        let swiftUIDetailVC = UIHostingController(rootView: CoinDetailView(coin: coin))
        swiftUIDetailVC.title = coin.name
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(swiftUIDetailVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coin = viewModel.filteredCoins[indexPath.row]
        let isFavorite = favoritesManager.isFavorite(coin)
        let favoriteAction = UIContextualAction(style: .normal, title: isFavorite ? "Unfavorite" : "Favorite") { [weak self] (_, _, completion) in
            self?.handleFavoriteAction(for: coin, isFavorite: isFavorite)
            completion(true)
        }
        // Customize the action's appearance
        favoriteAction.backgroundColor = isFavorite ? UIColor.theme.red : UIColor.theme.green
        favoriteAction.image = UIImage(systemName: isFavorite ? "heart.slash.fill" : "heart.fill")
        
        // Return the swipe actions configuration
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
    
    private func handleFavoriteAction(for coin: CoinList, isFavorite: Bool) {
        if isFavorite {
            favoritesManager.removeFavorite(coin)
        } else {
            favoritesManager.addFavorite(coin)
        }
        viewModel.updateFilteredCoins()
        if viewModel.showFavoritesOnly {
            tblCoin.reloadData()
        } else if let index = viewModel.filteredCoins.firstIndex(where: { $0.uuid == coin.uuid }) {
            tblCoin.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
}

// MARK: - UISearchBarDelegate
extension CoinListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCoins(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.searchCoins(searchText: "")
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

// MARK: - UIScrollViewDelegate
extension CoinListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.showFavoritesOnly { return }
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Load more data when the user is near the bottom
        if offsetY > contentHeight - height, viewModel.canLoadMore(), !viewModel.isLoading {
            viewModel.fetchCoins()
        }
    }
}
