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
downloadGDriveFile(out="Covid19_DATA2.tar.gz", id="175re3N107yc6r018I6JqJD7AMRsS-lkm")


message("Unzipping Data")
system("tar -xzf Covid19_DATA2.tar.gz -C ./ ", intern=TRUE)

message("Done")
