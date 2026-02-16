//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = [] // Navigation path

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                VStack {
                    TextField("Search devices...", text: $viewModel.searchQuery)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    if viewModel.data.isEmpty {
                        ProgressView("Loading...")
                    } else {
                        DevicesList(devices: viewModel.filteredData) { selectedComputer in
                            viewModel.navigateToDetail(navigateDetail: selectedComputer)
                        }
                    }
                }
            }
            .onChange(of: viewModel.navigateDetail, {
                if let navigate = viewModel.navigateDetail {
                     path.append(navigate)
                     viewModel.navigateDetail = nil // Reset state to prevent re-triggering
                }
            })
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                viewModel.fetchAPI()
            }
        }
    }
}
