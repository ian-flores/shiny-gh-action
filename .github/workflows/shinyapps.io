on:
  push:
    branches: master

name: shinyapps.io

jobs:
  shinyapps.io:
    runs-on: macOS-latest
    env:
      GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - uses: actions/checkout@v2

      - uses: r-lib/actions/setup-r@v1
      
      - name: Install dependencies
        run: |
          install.packages('shiny', 'rsconnect')
        shell: Rscript {0}
        
      - name: Set Up shinyapps.io credentials and publish
        run |
          rsconnect::setAccountInfo(name=${{secrets.RSCONNECT_ACCOUNT}}, token=${{secrets.RSCONNECT_TOKEN}}, secret=${{secrets.RSCONNECT_SECRET}})
          rsconnect::deployApp()
      
