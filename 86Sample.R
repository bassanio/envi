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
downloadGDriveFile(out="Covid19_Data_68Samples.tar.gz", id="1mI32lLRw-ejnqyF3p4Qr2r9InCHHdaCD")
## downloadGDriveFile(out="Covid19_DATA2.tar.gz", id="175re3N107yc6r018I6JqJD7AMRsS-lkm")


message("Unzipping Data")
system("tar -xzf Covid19_Data_68Samples.tar.gz -C ./ ", intern=TRUE)
## system("tar -xzf Covid19_DATA2.tar.gz -C ./ ", intern=TRUE)


#' R package cache (precompiled packages based on colab env)
message("Download R package cache")
downloadGDriveFile(out="r_binaries.tar.gz", id="1PYHHm5yM69rWJrRxK3FHfQVzvzU1I8JM")

#' Unpack cache locally
message("Unzipping R package cache")
system("tar -xzf r_binaries.tar.gz -C / ", intern=TRUE)

#' Set correct library path
.libPaths(Sys.getenv("R_LIBS_USER"))


# Options to make plots smaller
options(repr.plot.width=4, repr.plot.height=4)

message("Done")
