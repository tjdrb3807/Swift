import UIKit

// 인스턴스의 타입을 확인하거나 어떠한 클래스의 인스턴스를 해당 클래스 계층 구조의 슈퍼 클래스나 서브 클래스로 취급 하는 방법
// is, as

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artiest: String
    init(name: String, artiest: String) {
        self.artiest = artiest
        super.init(name: name)
    }
}

let library = [
    Movie(name: "기생충", director: "봉준호"),
    Song(name: "Butter", artiest: "BTS"),
    Movie(name: "올드보이", director: "박찬욱"),
    Song(name: "Wonderwall", artiest: "Oasis"),
    Song(name: "Rain", artiest: "이적")
]

var moviceCount = 0
var songCount = 0

// is 연잔사를 통해 인스턴스의 타입을 확인할 수 있다.
for item in library {
    if item is Movie {
        moviceCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(moviceCount) movies and \(songCount) songs")

// 반환 타입이 확실한 경우에만 !사용, 확실하지 않을 경우에는 ?을 사용해서 Optonal 반환
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir: \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), art: \(song.artiest)")
    }
}
