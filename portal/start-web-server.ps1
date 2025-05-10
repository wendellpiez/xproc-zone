# Calls Pode (web server for Powershell) - https://github.com/Badgerati/Pode
# To install: https://github.com/Badgerati/Pode?tab=readme-ov-file#-install
# Suggestion (as Administrator): Install-Module -Name Pode
# There are some hoops to jump through
# For example, see a page at http://localhost:8080/24MY_WRX_G9060BE_V2/HTML/contents/index.html

Start-PodeStaticServer -Port 8080
