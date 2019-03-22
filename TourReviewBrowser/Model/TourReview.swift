struct TourReview: Codable {
    
    enum CodingKeys: String, CodingKey {
        case entityID                   = "review_id"
//        case date                       = "date_unformatted"
        case formattedDate              = "date"
        case title
//        case rating
        case message
        case isForeignLanguage          = "foreignLanguage"
        case languageCode
        case isAnonymous
        case authorName                 = "author"
        case reviewerName
        case reviewerFirstInitial       = "firstInitial"
        case reviewerProfilePhotoURL    = "reviewerProfilePhoto"
        case reviewerCountryName        = "reviewerCountry"
    }
    
    let entityID: Int
    let title: String?
//    let date: Int?
    let formattedDate: String
//    let rating: Float
    let message: String
    let isForeignLanguage: Bool
    let languageCode: String
    let isAnonymous: Bool
    let authorName: String
    let reviewerName: String
    let reviewerFirstInitial: String
    let reviewerProfilePhotoURL: String?
    let reviewerCountryName: String
    
    //    let travelerTypeCode: String
    //    "traveler_type": "couple",
}
