//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData] = []
    @Published var searchQuery: String = ""
    
    var filteredData: [DeviceData] {
        if searchQuery.isEmpty {
            return data
        } else {
            return data.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    func fetchAPI() {
        apiService.fetchDeviceDetails { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.data = data
                case .failure(let error):
                    print("Error fetching data: \(error)")
                    self?.data = []
                }
            }
        }
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
