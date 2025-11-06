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


downloadGDriveFile2 <- function(out, id) {
  # Install gdown into the Python env (quiet)
  system("pip -q install gdown")

  # Use Python to download by file ID (robust to Drive's confirm token)
  cmd <- sprintf('python - << "PY"
import gdown
gdown.download(id="%s", output="%s", quiet=False)
PY', id, out)

  status <- system(cmd)
  if (status != 0 || !file.exists(out)) {
    stop("Download failed. Check that the Drive file share is 'Anyone with the link' and the ID is correct.")
  }
  message("✅ Downloaded: ", out)
}



message("Download R package cache")
downloadGDriveFile2(out="R_env_2025.tar.gz", id="1PiPreD5sH-FylBgeKzI70f8SqglQ0Awwf")

#' Unpack cache locally
#message("Unzipping R package cache")
system("tar -xzf R_env_2025.tar.gz -C ./")

#system("tar -xzf r_binaries.tar.gz -C / ", intern=TRUE)


message("Done")
