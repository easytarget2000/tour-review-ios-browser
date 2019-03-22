struct TourReview: Codable {
    
    enum CodingKeys: String, CodingKey {
        case entityID = "review_id"
    }
    
    let entityID: Int
    
//    let rating: Float
//    
//    let title: String
//    
//    let message: String
//    
//    let author: String
//    
//    let foreignLange: Bool
//    
//    let formattedDate: String
//    
//    let date: Int?
//    
//    let languageCode: String
//    
//    let travelerTypeCode: String
//    
//    let reviewerName: String
//    
//    let reviewerProfilePhotoURL: String?
//    
//    let isAnonymous: Bool
//    
//    let firstInitial: String
    
//    "review_id": 5203197,
//    "rating": "5.0",
//    "title": "Excellent guide and a fascinating place.",
//    "message": "Difficult to find starting point from instructions given but could not fault the tour from then on. Lots of stairs. Guide was knowledgeable and humorous with good language skills. Would not have missed it for the world. Fascinating place with an interesting history.",
//    "author": "Raymond – United Kingdom",
//    "foreignLanguage": false,
//    "date": "March 21, 2019",
//    "date_unformatted": {},
//    "languageCode": "en",
//    "traveler_type": "couple",
//    "reviewerName": "Raymond",
//    "reviewerCountry": "United Kingdom",
//    "reviewerProfilePhoto": null,
//    "isAnonymous": false,
//    "firstInitial": "R"
}
