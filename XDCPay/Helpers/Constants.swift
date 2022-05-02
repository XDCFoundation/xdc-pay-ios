//
//  Constants.swift
//  NFT_Marketplace
//
//  Created by Developer on 13/09/21.
//

import Foundation
import UIKit
import HDWalletKit
 
var baseUrl3000 = "http://xdc-nft-elb-1240623583.us-east-2.elb.amazonaws.com:3000/" // Users
var baseUrl3001 = "http://xdc-nft-elb-1240623583.us-east-2.elb.amazonaws.com:3001/" //
var baseUrl3002 = "http://xdc-nft-elb-1240623583.us-east-2.elb.amazonaws.com:3002/" // Content
var baseUrl3003 = "http://xdc-nft-elb-1240623583.us-east-2.elb.amazonaws.com:3003/" // Notification Service 

struct Constants {
    
    static let appName = "Fleek"
    
    
    static let Content_Details = baseUrl3002 + "user-content"
    static let like_Video = baseUrl3002 + "like-dislike-video"
    


    static let publishVideo = "content"

    static let homeDetails = "user-content"
    static let categoryContent = "category-content"

    static let Publish_Vedios = baseUrl3002 + "content"
    static let Owned_Videos = "total-owned-videos"
    static let Purchased_Videos = "purchased-by-user"
    static let Sold_Videos = "sold-by-user"
    static let OnSale_Videos = "total-onsale-videos"
    static let Draft_Videos = "draft-videos"
    static let Content_Preference_ForYou = baseUrl3002 + "preference-content"
    static let Contact = baseUrl3002 + "contact-us"
    static let delete_Comments = baseUrl3002 + "delete-comment"
    static let mark_as_favorite = baseUrl3002 + "mark-as-favorite" //unmark-as-favorite
    static let unmark_as_favorite = baseUrl3002 + "unmark-as-favorite"
    static let Comment_List = baseUrl3002 + "comments"
    static let Post_Comment = baseUrl3002 + "comment-on-nft"
    static let Report_Comment = baseUrl3002 + "report-comment"
    static let Like_Comment = baseUrl3002 + "like-comment"
    static let Dislike_Comment = baseUrl3002 + "dislike-comment"
    static let Search_Video = baseUrl3002 + "filter"
    static let Favourite_List = baseUrl3002 + "all-favourites"
    static let Edit_Favourite_List = baseUrl3002 + "delete-favourites"
    
    static let update_user_Details =  "update-user-details"
    static let Change_Password = baseUrl3000 + "change-password"
    static let Buy_NFT = baseUrl3002 + "buy-nft"
    static let Sell_NFT = baseUrl3002 + "sell-nft"
    static let upload_photo = baseUrl3001 + "upload-file"
    static let Report_Video = baseUrl3002 + "report-video"
    
    static let Notification_List = baseUrl3003 + "notification-list"
    static let Following_List = baseUrl3000 + "get-following-list"
    static let Get_Privacy_Details = baseUrl3002 + "get-privacy-policy?userId=userId"
    static let forgot_Password = baseUrl3000 + "forgot-password"
    static let get_user_view = baseUrl3002 + "views-earnings-of-user"
    static let mark_As_Not_Interested = baseUrl3000 + "mark-not-interested"
    static let pricing_History = baseUrl3002 + "pricing-history"
    static let trading_History = baseUrl3002 + "trading-history"
    static let get_userBy_userId = baseUrl3000 + "user-by-userId"
    static let Search_CategoryContent = baseUrl3002 + "get-new-category-videos"
    static let Search_TrendingContent = baseUrl3002 + "get-trending-hashtag-videos"
    static let searchTrendingVideos = "get-trending-hashtag-videos"
    static let searchCategoriesVideos = "get-new-category-videos"
    static let follow_unfollow_user = baseUrl3000 + "follow-unfollow-user"
    static let Sign_Up = baseUrl3000 + "signup"
    static let SignUP_Social = baseUrl3000 + "signup-social"
    static let For_You = baseUrl3002 + "for-you"
    static let MarketPlace = baseUrl3002 + "marketplace"
    static let isFollowingUser = baseUrl3000 + "isFollowingTheUser"
    static let getTransaction = baseUrl3002 + "transactions"
    
    static let Get_xdc_price = "https://1lzur2qul1.execute-api.us-east-2.amazonaws.com/prod/getCoinMarketCap/USD"
    static let get_buying = baseUrl3002 + "buying/"
    static let put_buying = baseUrl3002 + "buying"
    static let put_manage_notification = baseUrl3000 + "edit-user-details"
    
    static let userByUserId = baseUrl3000 + "user-by-userId"

    static let user_Info = "user-profile"
    static let update_content_preferences = "update-content-preference"
    
}

extension Constants {
    static let oneSignalID = "1192cd82-e183-461d-8bec-2915f8889fea"
    
    static let visitOurWebsiteUrl = "https://www.xdc.org/"
    static let privacyPolicyUrl = "https://www.xdc.org/privacy"
    static let contactUsUrl = "https://www.xdc.org/contact-us"
    static let termsConditionUrl = "https://www.xdc.org/"
    
    static let infoHelpStr =
"""
Dear XDCPay Users,
    
XDCPay is a beta software.

When you log in to XDCPay, your current account’s address is visible to every new site you visit. This can be used to look up your account balances of XDC and other tokens.

For your privacy, for now, please sign out of XDC Pay when you’re done using a site.

Related Links
"""
}

extension Constants {
    static func videoCategory(categoryName: String) -> String {
        //Remove this from Api
        let userId = UserDefaults.standard.string(forKey: "userId") ?? "null"
        let tempURLStr = "category-content?category=\(categoryName)&userId=\(userId)"
        let finalURL = tempURLStr.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        return baseUrl3002 + (finalURL ?? "")
    }
}


let primaryColor = UIColor(red: 255.0/255.0, green: 196.0/255.0, blue: 0.0/255.0, alpha: 1.0)
typealias Handler<T> = (T) -> Void


enum AppColors: String {
    case placeholderColor = "848484"
    case textColor = "2A2A2A"
    case darkColor = "707070"
    
    func color() -> UIColor {
        return UIColor(hexCode: rawValue)
    }
}

