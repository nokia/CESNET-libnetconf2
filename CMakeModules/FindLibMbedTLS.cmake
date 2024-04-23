# - Try to find LibMbedTLS
# Once done this will define
#
#  LIBMBEDTLS_FOUND - system has LibPAM
#  LIBMBEDTLS_INCLUDE_DIRS - the LibPAM include directory
#  LIBMBEDTLS_LIBRARIES - link these to use LibPAM
#
#  Author Roman Janota <xjanot04@fit.vutbr.cz>
#  Copyright (c) 2024 CESNET, z.s.p.o.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#
#  1. Redistributions of source code must retain the copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#  3. The name of the author may not be used to endorse or promote products
#     derived from this software without specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
#  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

if(LIBMBEDTLS_LIBRARIES AND LIBMBEDTLS_INCLUDE_DIRS)
  # in cache already
  set(LIBMBEDTLS_FOUND TRUE)
else()
  find_path(LIBMBEDTLS_INCLUDE_DIR
    NAMES
      mbedtls/ssl.h
    PATHS
      /opt/local/include
      /sw/include
      ${CMAKE_INCLUDE_PATH}
      ${CMAKE_INSTALL_PREFIX}/include
  )

  find_library(LIBMBEDTLS_LIBRARY
    NAMES
      libmbedtls.so # TODO
    PATHS
      /usr/lib
      /usr/lib64
      /opt/local/lib
      /sw/lib
      ${CMAKE_LIBRARY_PATH}
      ${CMAKE_INSTALL_PREFIX}/lib
  )

  find_library(LIBMBEDX509_LIBRARY
    NAMES
      libmbedx509.so
    PATHS
      /usr/lib
      /usr/lib64
      /opt/local/lib
      /sw/lib
      ${CMAKE_LIBRARY_PATH}
      ${CMAKE_INSTALL_PREFIX}/lib
  )

  find_library(LIBMBEDCRYPTO_LIBRARY
    NAMES
      libmbedcrypto.so
    PATHS
      /usr/lib
      /usr/lib64
      /opt/local/lib
      /sw/lib
      ${CMAKE_LIBRARY_PATH}
      ${CMAKE_INSTALL_PREFIX}/lib
  )

  if(LIBMBEDTLS_INCLUDE_DIR AND LIBMBEDTLS_LIBRARY AND LIBMBEDX509_LIBRARY AND LIBMBEDCRYPTO_LIBRARY)
    set(LIBMBEDTLS_FOUND TRUE)
  else()
    set(LIBMBEDTLS_FOUND FALSE)
  endif()

  set(LIBMBEDTLS_INCLUDE_DIRS ${LIBMBEDTLS_INCLUDE_DIR})
  set(LIBMBEDTLS_LIBRARIES ${LIBMBEDTLS_LIBRARY} ${LIBMBEDX509_LIBRARY} ${LIBMBEDCRYPTO_LIBRARY})

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(LibMbedTLS DEFAULT_MSG LIBMBEDTLS_LIBRARIES LIBMBEDTLS_INCLUDE_DIRS)

  # show the LIBMBEDTLS_INCLUDE_DIRS and LIBMBEDTLS_LIBRARIES variables only in the advanced view
  mark_as_advanced(LIBMBEDTLS_INCLUDE_DIRS LIBMBEDTLS_LIBRARIES)
endif()