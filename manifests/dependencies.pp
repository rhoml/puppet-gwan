class gwan::dependencies {
  case $operatingsystem {
    Ubuntu,Debian: { require gwan::dependencies::ubuntu }
    RedHat,CentOS: { require gwan::dependencies::centos }
  }
}
