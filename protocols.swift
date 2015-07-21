protocol Feed {
  var url:String { get }
}

protocol Folder {
  var feeds:[Feed] { get }
  func add(newFeeds:[Feed])
}

class LocalFolder: Folder {
  var feeds = [Feed]()
  func add(newFeeds:[Feed]) {
    feeds += newFeeds.filter { newFeed in !self.feeds.contains { $0.url == newFeed.url } }
  }
}
