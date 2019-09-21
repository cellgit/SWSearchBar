# SWSearchBar

#### Custom SearchBar and System SearchBar

一. 使用说明:

##### Custom SearchBar

```
let searchBarView = SWSearchBarView.init(frame: CGRect(x: kPadding, y: 200, width: self.view.bounds.width - kPadding*2, height: 38))
self.navigationItem.titleView = searchBarView   // add to navigation

// self.view.addSubview(searchBarView) //add to normal view
```

##### System SearchBar
```
override func viewDidLoad() {
     super.viewDidLoad()
     self.view.backgroundColor = .white
     self.title = "SearchBar"
        
     if #available(iOS 11.0, *) {
         navigationController?.navigationBar.prefersLargeTitles = true
         navigationItem.searchController = UISearchController.init(searchResultsController: nil)
     }
     definesPresentationContext = true
}
```