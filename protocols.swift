protocol Feed {
	var url:String { get }
}

protocol Folder {
	var feeds:[Feed] {get set} //needs to be mutable if using protocol extension
	func add(newFeeds:[Feed])
}

// default implementation, optional
extension Folder {
	mutating func add(newFeeds:[Feed]) {
		for newFeed in newFeeds {
			if !feeds.contains({ $0.url == newFeed.url }) {
				feeds.append(newFeed)
			}
		}
	}
}

// concrete implementation
class LocalFolder: Folder {
	var feeds = [Feed]()
	func add(newFeeds:[Feed]) {
		feeds += newFeeds.filter { newFeed in !self.feeds.contains { $0.url == newFeed.url } }
	}
}

struct sA: Feed {
	var url = "StructA"
}

class sB: Feed {
	var url = "StructB"
}

struct sC: Feed {
	var url = "StructC"
}

var tf = LocalFolder()
var arr:[Feed] = [sA(), sB(), sC()]
tf.add([sA(), sB(), sC()])
tf.add([sA()])
print(tf.feeds)
