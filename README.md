# Sepia-Pets

** PetDetails - Model Class
  ** Pet
     - containes pets as aproperty, its an array of PetDetails.
     
  ** PetDetails
     - containes all properties for pets with coding keys.
    
** PetListViewModel - View Model Class
     - It has all the bussiness logic like getting pets list and data handling parts.
    
    **Methods
        *func getPetsList(fileName: String, extensionName:String, completion: ((Pet?)-> ())? = nil )
            - To get the pets list.
            
        *func getUrlFromFile(fileName: String, extensionName: String) -> URL?
            - To get the URL from given file name and file extension.
            
        *func getDataFromUrl(url: URL) -> Data?
             - To get the Data from given URL.
             
        *func downloadImageFromUrl(imageUrl: String) -> UIImage?
            - For downloading the image from the given url.
            
** PetListTableViewController - View class
        - For listing all pets details, like showing name and image of the pets in row wise.
        **Property
          * viewModel - PetsListViewModeling
              - Its a protocol which has one get property and one method.
               *pets
                    - we can get array of PetDetails from this.
               *func getImageFromUrl(imageUrl: String) -> UIImage?
                    - we can get image from given url.
                    
** PetListTableViewCell - Cell class  
        - It containes 2 outlets and a method for setting values to the outlets.
            * labelPetTitle: UILabel
                - To display the title of the pet.
            * imageViewPet: UIImageView
                - To display the image of the pet.
            *func setValues(petDetails: PetDetails, image: UIImage?)  
                - For setting values to label and image. we are calling this method from cell for indexpath.
                
** PetDetailsViewModel - View Model Class
     - It has all the bussiness logic like getting URLRequest for loading WebView.
     **Methods
        * func getUrlRequest(contentUrl: String?)
            - To get the URLRequest from the pet details content URL.
            
** PetDetailsViewController - View class
        - For loading pet details from the given url. 
        ** Properties
                *webViewPetDetails: WKWebView
                    - for loading content from url.
                *viewModel: PetDetailsViewModeling
                    - instance of a viewModel protocol, to get URL request from view model.
       ** Methods
               *func loadWebView() 
                    - To load contemt in the webView.
                
** PetListTests - XCTestCase
            - It has all the positive and negative test caees of PetListViewModel.
            
** PetDetailsTests - XCTestCase
            - It has all the positive and negative test caees of PetDetailsViewModel.                     
