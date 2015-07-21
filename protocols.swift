protocol Feed {
  var url:String { get }
}

protocol Folder {
  var feeds:[Feed] { get set } //needs to be mutable if using protocol extension
  func add(newFeeds:[Feed])
}

extension Folder {
  mutating func add(newFeeds:[Feed]) {
    for newFeed in newFeeds {
      if !feeds.contains({ $0.url == newFeed.url }) {
        feeds.append(newFeed)
    }
  }
}

class LocalFolder: Folder {
  var feeds = [Feed]()
  func add(newFeeds:[Feed]) {
    feeds += newFeeds.filter { newFeed in !self.feeds.contains { $0.url == newFeed.url } }
  }
}
