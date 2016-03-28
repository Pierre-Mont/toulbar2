ROOT=`git rev-parse --show-toplevel`
cd $ROOT
FILE=$ROOT/toulbar2/src/ToulbarVersion.hpp
PCKGVER=$ROOT/toulbar2/src/MyCPackConf.cmake
VERSION=`git describe --abbrev=0 --tags`
MAJOR=`echo $VERSION| cut -d"." -f1`
MINOR=`echo $VERSION| cut -d"." -f2`
PATCH=`echo $VERSION| cut -d"." -f3`
BRANCH=`git rev-parse --abbrev-ref HEAD`
CTIME=`date +"%s"`
HASH=`git log -1 --format=%h`

git diff --quiet HEAD > /dev/null 2>&1
if [ $? -ne 0 ]; then
  TAINTED="-tainted"
fi

echo "// Cmake generated version" > $FILE
echo "#define Toulbar_VERSION \"$VERSION-$BRANCH-$HASH$TAINTED ($CTIME)\"" >> $FILE

echo "SET(CPACK_PACKAGE_VERSION \"$VERSION\")" > $PCKGVER
echo "SET(CPACK_NSIS_DISPLAY_NAME \"toulbar2 $VERSION\")" >> $PCKGVER
echo "SET(CPACK_NSIS_PACKAGE_NAME \"toulbar2 $VERSION\")" >> $PCKGVER
echo "SET(CPACK_PACKAGE_FILE_NAME \"toulbar2-$VERSION-x86_64\")" >> $PCKGVER
echo "SET(CPACK_PACKAGE_INSTALL_DIRECTORY \"toulbar2 $VERSION\")" >> $PCKGVER
echo "SET(CPACK_PACKAGE_INSTALL_REGISTRY_KEY \"toulbar2 $VERSION\")" >> $PCKGVER
echo "SET(CPACK_PACKAGE_VERSION_MAJOR \"$MAJOR\")" >> $PCKGVER
echo "SET(CPACK_PACKAGE_VERSION_MINOR \"$MINOR\")" >> $PCKGVER
echo "SET(CPACK_PACKAGE_VERSION_PATCH \"$PATCH\")" >> $PCKGVER