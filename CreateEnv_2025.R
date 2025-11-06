#message("Update and install needed Ubuntu packages")
#system("apt update")
#system("apt install -y libmysqlclient-dev libudunits2-dev libgeos-dev libgdal-dev libcairo2-dev")

downloadGDriveFile <- function(id, out){
  system(paste0(
    'wget --continue --load-cookies /tmp/cookies.txt ',
    '"https://docs.google.com/uc?export=download&confirm=$(wget ',
    '--quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate ',
    "'https://docs.google.com/uc?export=download&id=", id, "' -O- | ",
    "sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\\1\\n/p')&id=", id, '" ',
    "-O ", out, " && rm -rf /tmp/cookies.txt"), intern=TRUE)
}

message("Retrieve data for tutorials")
message("Download Data")
downloadGDriveFile(out="PAGData.tar.gz", id="1W2TJYI1Fc_d7DlYgTLFxaoxeFZ95jZec")


message("Unzipping Data")
system("tar -xvzf PAGData.tar.gz -C ./ ", intern=TRUE)

message("Done Data Download")


message("Start installing packages")



# 1) Install gdown into the Python env
system("pip -q install gdown")

# 2) Download your tarball using the full Drive URL (no manual ID needed)
drive_url <- "https://drive.google.com/file/d/1PiPreD5sH-FylBgeKzI70f8SqglQ0Aww/view?usp=share_link"
out_file  <- "R_env_2025.tar.gz"
cmd <- sprintf('gdown --fuzzy "%s" -O "%s"', drive_url, out_file)
print(cmd)
status <- system(cmd)
if (status != 0 || !file.exists(out_file)) {
  stop("Download failed. Make sure the Drive file is shared as 'Anyone with the link → Viewer'.")
}

# 3) Extract to root ('/') because the tarball contains absolute paths
#    like /usr/local/lib/R/site-library/...
system("rm -rf /usr/local/lib/R/site-library/usr")   # clean accidental nested path
untar(out_file, exdir = "/", compressed = "gzip")

# 4) Point R to the system library and test
.libPaths("/usr/local/lib/R/site-library")
suppressPackageStartupMessages({
  library(DESeq2)
  library(ggplot2)
  library(dplyr)
})
message("✅ Packages loaded.")

