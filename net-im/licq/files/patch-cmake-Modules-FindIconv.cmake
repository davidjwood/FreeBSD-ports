--- cmake/Modules/FindIconv.cmake.orig	2014-06-01 19:16:42 UTC
+++ cmake/Modules/FindIconv.cmake
@@ -10,6 +10,7 @@
 # 
 include(CheckCCompilerFlag)
 include(CheckCXXSourceCompiles)
+include(CheckFunctionExists)
 
 IF (ICONV_INCLUDE_DIR AND ICONV_LIBRARIES)
   # Already in cache, be silent
@@ -18,11 +19,15 @@ ENDIF (ICONV_INCLUDE_DIR AND ICONV_LIBRA
 
 FIND_PATH(ICONV_INCLUDE_DIR iconv.h) 
  
-FIND_LIBRARY(ICONV_LIBRARIES NAMES iconv libiconv c)
- 
-IF(ICONV_INCLUDE_DIR AND ICONV_LIBRARIES) 
-   SET(ICONV_FOUND TRUE) 
-ENDIF(ICONV_INCLUDE_DIR AND ICONV_LIBRARIES) 
+IF(ICONV_INCLUDE_DIR)
+  CHECK_FUNCTION_EXISTS(iconv ICONV_FOUND)
+  IF(NOT ICONV_FOUND)
+    FIND_LIBRARY(ICONV_LIBRARIES NAMES iconv libiconv libiconv-2)
+    IF(ICONV_LIBRARIES)
+      SET(ICONV_FOUND TRUE)
+    ENDIF(ICONV_LIBRARIES)
+  ENDIF(NOT ICONV_FOUND)
+ENDIF(ICONV_INCLUDE_DIR)
 
 set(CMAKE_REQUIRED_INCLUDES ${ICONV_INCLUDE_DIR})
 set(CMAKE_REQUIRED_LIBRARIES ${ICONV_LIBRARIES})