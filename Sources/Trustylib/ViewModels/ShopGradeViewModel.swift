//
//  ShopGradeViewModel.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 27/02/23.
//

import Foundation

/**
 ShopGradeViewModel serves ShopGradeView for managing view states and
 getting shop grade details for the given channel id.
 */
class ShopGradeViewModel: ObservableObject {
        
    // MARK: Public properties
    
    @Published var shopAggregateRatings: ShopAggregateRatingsModel?
    
    /**
     Calls Trustedshops aggregate ratings API to get shop's grade details
     */
    func loadAggregateRating(for channelId: String, responseHandler: @escaping ResponseHandler<Bool>) {
        guard !channelId.isEmpty else {
            TSConsoleLogger.log(
                messege: "Error loading shop grade details due to invalid channel id",
                severity: .info
            )
            responseHandler(false)
            return
        }
        
        self.getAuthenticationTokenIfNeeded { [weak self] didGetToken in
            guard didGetToken else {
                responseHandler(false)
                return
            }
            
            let shopGradeDataService = ShopGradeDataService()
            shopGradeDataService.getAggregateRatings(for: channelId) { [weak self] ratings in
                guard let strongSelf = self,
                      let aggregateRatings = ratings else {
                    TSConsoleLogger.log(
                        messege: "Error loading shop grade details",
                        severity: .error
                    )
                    responseHandler(false)
                    return
                }
                
                TSConsoleLogger.log(
                    messege: "Successfully loaded shop grade details for channel \(channelId)",
                    severity: .info
                )
                strongSelf.shopAggregateRatings = aggregateRatings
                responseHandler(true)
            }
        }
    }

    /**
     Calls Trustedshops authentication service to obtain authentication token required for
     API calls that return details like shop grade, product grade, etc
     */
    func getAuthenticationTokenIfNeeded(responseHandler: @escaping ResponseHandler<Bool>) {
        guard TSAuthenticationService.shared.isAccessTokenExpired else {
            responseHandler(true)
            return
        }
        
        TSAuthenticationService.shared.getAuthenticationToken { didAuthenticate in
            guard didAuthenticate else {
                TSConsoleLogger.log(
                    messege: "Authentication error, failed to obtain authentication token",
                    severity: .error
                )
                responseHandler(false)
                return
            }

            TSConsoleLogger.log(
                messege: "Successfully recieved authentication token",
                severity: .info
            )
            responseHandler(true)
        }
    }
}
