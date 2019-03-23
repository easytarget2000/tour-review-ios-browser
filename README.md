# Tour Review iOS Browser #
Coding challenge, an iPhone app that reads from a public API and displays a list of results

## Summary ##
The task of this challenge was to create an iPhone app that reads from a public API and displays the data. The API returns a list of reviews for guided tours. A review contains a rating, a message and information about the author.

After years of blindly using Alamofire for API calls in iOS, I decided to use this opportunity to look into a different approach. I chose <a href="https://github.com/bustoutsolutions/siesta">Siesta</a> for its lightweight style, caching capabilities and elegant response transformation.

## Compilation ##
This project uses CocoaPods to add the Siesta repository to the Xcode project. Before building the project and with CocoaPods installed, run `pod install` in project's root directory.

## Structure ##

## Potential features ##
* Sorting
* Separate detail screen for individual reviews
* Pagination of API call
