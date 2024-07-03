```

name: Check PR for Screenshot or Video

on:
  pull_request:
    branches: '**'  # Apply to pull requests targeting any branch
    types: [opened, edited, synchronize, ready_for_review]

jobs:
  check-pr-content:
    runs-on: ubuntu-latest

    steps:
    - name: Check PR for image or video
      uses: actions/github-script@v6
      with:
        script: |
          // Extract PR description
          const prBody = context.payload.pull_request.body;

          // Regex patterns for images and videos
          const imageRegex = /!\[.*\]\(.*\)|<img .*src=.*>/; // Markdown or HTML image
          const videoRegex = /(https?:\/\/.*\.(?:mp4|mov|avi|wmv|flv|mkv|webm|ogg)|<video .*src=.*>)/i; // Video URL or HTML video

          // Check if PR description includes images or videos
          if (!imageRegex.test(prBody) && !videoRegex.test(prBody)) {
            // Add a comment to the PR if no images or videos are found
            const issueComment = context.issue({
              body: 'Please include a screenshot or video in the PR description.',
            });
            return github.issues.createComment(issueComment);
          }


```
