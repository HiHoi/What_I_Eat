//
//  RestaurantViewModel.swift
//  WhatIEat
//
//  Created by Hosung Lim on 1/14/24.
//

import Foundation

class RestaurantViewModel: ObservableObject {
	@Published var restaurantModel: RestaurantModel?
	@Published var randomThumbnailPhoto: [String]?
	private var network: NetworkModel = NetworkModel()
	
	func loadRandomPageData() {
		print("로드 시작")
		network.getRandomPageData() { randomRestaurant in
			if let randomRestaurant = randomRestaurant {
				let randomData = randomRestaurant.data
				let imageList = randomData.map { Restaurant in
					return Restaurant.음식이미지URL
				}
				DispatchQueue.main.async {
					self.randomThumbnailPhoto = imageList
					print(imageList)
				}
			} else {
				print("언래핑 실패")
				DispatchQueue.main.async {
					self.randomThumbnailPhoto = nil
				}
			}
		}
	}
	
	func loadRandomImages() async {
		if let randomImage = await network.getRandomImageData() {
			let randomData = randomImage.data
			let imageList = randomData.map { restaurant in
				return restaurant.음식이미지URL
			}
			randomThumbnailPhoto = imageList
		} else {
			print("언래핑 실패")
			randomThumbnailPhoto = nil
		}
	}
}
