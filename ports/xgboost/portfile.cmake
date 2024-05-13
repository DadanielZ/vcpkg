vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO dmlc/xgboost
    REF v1.7.6
    SHA512 4465f383df70ee415faaeb745459bfc413f71bff0d02e59e67173975188bed911044dbea1a456550496f8c5a7c0b50002275b6be72c87386a6118485e1e41829
    HEAD_REF master
)

# Set the expected path of the dmlc-core directory inside the xgboost source directory
vcpkg_from_github(
    OUT_SOURCE_PATH DMLC_CORE_SRC
    REPO dmlc/dmlc-core
    REF 81db539486ce6525b31b971545edffee2754aced
    SHA512 9b288fd1ceeef0015e80b0296b0d4015238d4cc1b7c36ba840d3eabce87508e62ed5b4fe61504f569dadcc414882903211fadf54aa0e162a896b03d7ca05e975
    HEAD_REF master
)

# Custom CMake script to move dmlc-core to the correct location
file(REMOVE_RECURSE "${SOURCE_PATH}/dmlc-core")
file(RENAME "${DMLC_CORE_SRC}" "${SOURCE_PATH}/dmlc-core")

# Configure and build dmlc-core first
vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}/dmlc-core"
    PREFER_NINJA
    OPTIONS
         -DBUILD_SHARED_LIBS=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/xgboost" RENAME copyright)
