# Sportify

A dynamic iOS application built using Swift and UIKit that allows sports enthusiasts to explore various sports, browse leagues, check upcoming/past events, and save their favorite leagues for offline viewing. The app integrates with **TheSportsDB API** for real-time data and utilizes **CoreData** for local persistence.

---

## 📱 Features & Architecture

### 1. Sports Explorer (Main Screen - Tab 1)

* **Grid Layout:** Displays all available sports using a customized `UICollectionView` featuring a clean 2-column grid layout with elegant spacing.
* **Visual Richness:** Each cell showcases the sport's thumbnail (`strSportThumb`) and name (`strSport`).
* **Navigation:** Selecting a sport seamlessly navigates the user to the Leagues screen.

### 2. Favorite Leagues (Main Screen - Tab 2)

* **Offline Support:** Powered by **CoreData** to save and manage user-favorite leagues locally.
* **Smart Connectivity Checks:**
* If the user is **online**, tapping a favorite league redirects them to the detailed league view.
* If the user is **offline**, a smooth alert banner/pop-up prompts them that an active internet connection is required.



### 3. Leagues Viewer

* **Custom TableView:** Implements a `UITableViewController` with custom cells.
* **Elegant UI:** Displays a circular league badge (`strBadge`) alongside the league's name (`strLeague`).

### 4. League Details

An advanced, multi-sectioned view tracking everything happening within a specific league. It features three distinct sections:

* **Upcoming Events:** A horizontal scrolling `UICollectionView` showcasing match names (`strEvent`), dates, times, and competing team badges.
* **Latest Results:** A vertical scrolling `UICollectionView` detailing historical match scores (`intHomeScore` vs `intAwayScore`), dates, times, and team imagery.
* **Teams Roster:** A horizontal carousel displaying circular team logos. Tapping any team transitions into the Team Details view.

### 5. Team Details

* A beautifully designed, custom profile view highlighting the essential details of a selected team, focusing on clean typography and visual balance.

---

## 🛠️ Tech Stack & Libraries

* **Language:** Swift 5
* **Framework:** UIKit (Storyboard / Programmatic UI)
* **Architecture:** MVC / MVVM *(Choose whichever you used)*
* **Local Database:** CoreData (for caching favorite leagues)
* **Networking:** URLSession / Alamofire (for fetching data from TheSportsDB API)
* **Image Caching:** Kingfisher / SDWebImage (to handle smooth circular image loading and asynchronous caching)

---

## 📸 Screenshots

| Sports Directory | Leagues List | League Details |
| --- | --- | --- |
| *[Insert Sports Tab Screenshot]* | *[Insert Leagues Screenshot]* | *[Insert League Details Screenshot]* |

---

## 🚀 Getting Started

### Prerequisites

* Xcode 13+
* iOS 13.0+
* An API Key from [TheSportsDB](https://www.thesportsdb.com/)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/SportsHub.git

```


2. Open `SportsHub.xcodeproj` in Xcode.
3. Build and run the project on your preferred simulator or iOS device.


```
