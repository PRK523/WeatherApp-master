# WeatherApp

# Third Party libraries:
1) Alamofire - fetching data from the api url.
2) Swiftyjson - for easy handling of json data

# Architecture:
1) MVC
I'm working in my current Job on MVVM, but i'm not an expert on it so i implemented this project in MVC.
Yes, but i'm ready to learn it more deeply and work on it if that is requirement in my next job.

For LOADING the image url, in the weathermodel.swift you will see i have converted the URL into string using URL(string:_)

For navigating between the two screens, as soon as you load the app the first screen shows the current location weather(CoreLocation API) and the next screen shows the citites LONDON and TOKYO. Clicking on these two UIButtons you will come back to the first screen that shows the weather for the selected city.

# Data has been passed between VC's using Protocols and Delegates
# Navigation is done using Segues.



