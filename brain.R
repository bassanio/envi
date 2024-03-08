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

message("Done")


message("Download R package")
install.packages("topr")
install.packages("qqman")
#downloadGDriveFile(out="r_binaries.tar.gz", id="1-VqZb_Cv63AH8ogWwhSp48DUowzv_GQf")

#' Unpack cache locally
#message("Unzipping R package cache")
#system("tar -xzf r_binaries.tar.gz -C / ", intern=TRUE)



message("Done")
