
# YouTube App Clone Blueprint

## Overview

This document outlines the plan for creating a YouTube app clone using Flutter. The goal is to replicate the core features and UI of the YouTube mobile application.

## Style, Design, and Features

### Initial Version (v1)

*   **UI:**
    *   **Theme:** A modern, dark theme will be implemented using Material Design 3.
    *   **Color Scheme:** A color scheme will be generated from a seed color to ensure a consistent and harmonious look.
    *   **Typography:** Custom fonts will be used via the `google_fonts` package to match YouTube's typography.
    *   **Layout:** The layout will be responsive and adapt to different screen sizes.
*   **Core Features:**
    *   **Home Screen:** A home screen that displays a list of recommended videos.
    *   **Video List:** A vertically scrollable list of video thumbnails, titles, and channel information.
    *   **Navigation:** A bottom navigation bar for switching between different sections of the app (e.g., Home, Shorts, Subscriptions).
    *   **Video Detail Screen:** A screen that will eventually show the video player, comments, and related videos.
*   **Dependencies:**
    *   `google_fonts`: For custom fonts.
    *   `provider`: for state management.

### Version 2 (v2)

*   **UI:**
    *   **Responsive Layout:** The home screen now uses a `GridView` to display videos, which adjusts the number of columns based on the screen size.
    *   **Video Card:** The video cards have been redesigned to more closely match the YouTube UI, with a thumbnail, channel avatar, title, and subtitle.
    *   **AppBar:** The `AppBar` has been updated to include a search bar and additional action icons.
    *   **Filter Chips:** A scrollable row of filter chips has been added below the `AppBar`.

### Current Version (v3)

*   **Core Features:**
    *   **Video Player:** A video player screen has been added that embeds a video stream using a `WebView`.
    *   **Navigation:** Users can now tap on a video card to navigate to the video player screen.
*   **Dependencies:**
    *   `webview_flutter`: For embedding web content.

## Current Plan

### Step 3: Implement Video Player

1.  **Add `webview_flutter` Dependency:** Add the `webview_flutter` package to `pubspec.yaml`.
2.  **Create Video Player Screen:** Create a new screen that will host the `WebView`.
3.  **Embed Video:** Use the `WebView` widget to embed the video stream.
4.  **Implement Navigation:** Add navigation from the video cards to the video player screen.

