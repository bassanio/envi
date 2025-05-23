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
#downloadGDriveFile(out="Training_Dataset.tar.gz", id="1uxM4_qxgzyzWSYFUDr6BtlsHdJmfHHuD")
#downloadGDriveFile(out="Training_Dataset.tar.gz", id="1_0oN6jHHfgwASbqb3No5Honv_lWe_G7-")
downloadGDriveFile(out="Training_Dataset.tar.gz", id="1DNO9cUZ0Z4wNK15tZESVIcLU3xKuEHk9")


message("Unzipping Data")
system("tar -xvzf Training_Dataset.tar.gz -C ./ ", intern=TRUE)

message("Done")


message("Download and Install R package")
install.packages("qqman")
install.packages("IRdisplay")

library(IRdisplay)




message("Done")
