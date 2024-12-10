# Generated by OpenSSL

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Avoid duplicate find_package()
set(_ossl_expected_targets OpenSSL::Crypto OpenSSL::SSL
    OpenSSL::applink)
set(_ossl_defined_targets)
set(_ossl_undefined_targets)
foreach(t IN LISTS _ossl_expected_targets)
  if(TARGET "${t}")
    LIST(APPEND _ossl_defined_targets "${t}")
  else()
    LIST(APPEND _ossl_undefined_targets "${t}")
  endif()
endforeach()
message(DEBUG "_ossl_expected_targets = ${_ossl_expected_targets}")
message(DEBUG "_ossl_defined_targets = ${_ossl_defined_targets}")
message(DEBUG "_ossl_undefined_targets = ${_ossl_undefined_targets}")
if(NOT _ossl_undefined_targets)
  # All targets are defined, we're good, just undo everything and return
  unset(_ossl_expected_targets)
  unset(_ossl_defined_targets)
  unset(_ossl_undefined_targets)
  unset(CMAKE_IMPORT_FILE_VERSION)
  return()
endif()
if(_ossl_defined_targets)
  # We have a mix of defined and undefined targets.  This is hard to reconcile,
  # and probably the result of another config, or FindOpenSSL.cmake having been
  # called, or whatever.  Therefore, the best course of action is to quit with a
  # hard error.
  message(FATAL_ERROR "Some targets defined, others not:\nNot defined: ${_ossl_undefined_targets}\nDefined: ${_ossl_defined_targets}")
endif()
unset(_ossl_expected_targets)
unset(_ossl_defined_targets)
unset(_ossl_undefined_targets)


# Set up the import path, so all other import paths are made relative this file
get_filename_component(_ossl_prefix "${CMAKE_CURRENT_LIST_FILE}" PATH)

if(_ossl_prefix STREQUAL "/")
  set(_ossl_prefix "")
endif()


if(OPENSSL_USE_STATIC_LIBS)
  set(_ossl_use_static_libs True)
elseif(DEFINED OPENSSL_USE_STATIC_LIBS)
  # We know OPENSSL_USE_STATIC_LIBS is defined and False
  if(_ossl_use_static_libs)
    # OPENSSL_USE_STATIC_LIBS is explicitly false, indicating that shared libraries are
    # required.  However, _ossl_use_static_libs indicates that no shared libraries are
    # available.  The best course of action is to simply return and leave it to CMake to
    # use another OpenSSL config.
    unset(_ossl_use_static_libs)
    unset(CMAKE_IMPORT_FILE_VERSION)
    return()
  endif()
endif()

# Version, copied from what find_package() gives, for compatibility with FindOpenSSL.cmake
set(OPENSSL_VERSION "${OpenSSL_VERSION}")
set(OPENSSL_VERSION_MAJOR "${OpenSSL_VERSION_MAJOR}")
set(OPENSSL_VERSION_MINOR "${OpenSSL_VERSION_MINOR}")
set(OPENSSL_VERSION_FIX "${OpenSSL_VERSION_PATCH}")
set(OPENSSL_FOUND YES)

# Directories and names
set(OPENSSL_INCLUDE_DIR "${_ossl_prefix}/include")
set(OPENSSL_LIBRARY_DIR "${_ossl_prefix}/.")
set(OPENSSL_ENGINES_DIR "${_ossl_prefix}/engines")
set(OPENSSL_MODULES_DIR "${_ossl_prefix}/providers")
set(OPENSSL_RUNTIME_DIR "${_ossl_prefix}/apps")

set(OPENSSL_APPLINK_SOURCE "${_ossl_prefix}/ms/applink.c")

set(OPENSSL_PROGRAM "${OPENSSL_RUNTIME_DIR}/openssl.exe")

# Set up the imported targets
if(_ossl_use_static_libs)

  add_library(OpenSSL::Crypto STATIC IMPORTED)
  add_library(OpenSSL::SSL STATIC IMPORTED)

  set(OPENSSL_LIBCRYPTO_STATIC "${OPENSSL_LIBRARY_DIR}/libcrypto_static.lib")
  set(OPENSSL_LIBCRYPTO_DEPENDENCIES ws2_32.lib gdi32.lib advapi32.lib crypt32.lib user32.lib)
  set_target_properties(OpenSSL::Crypto PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    IMPORTED_LOCATION ${OPENSSL_LIBCRYPTO_STATIC})
  set_property(TARGET OpenSSL::Crypto
    PROPERTY INTERFACE_LINK_LIBRARIES ${OPENSSL_LIBCRYPTO_DEPENDENCIES})

  set(OPENSSL_LIBSSL_STATIC "${OPENSSL_LIBRARY_DIR}/libssl_static.lib")
  set(OPENSSL_LIBSSL_DEPENDENCIES OpenSSL::Crypto)
  set_target_properties(OpenSSL::SSL PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    IMPORTED_LOCATION ${OPENSSL_LIBSSL_STATIC})
  set_property(TARGET OpenSSL::SSL
    PROPERTY INTERFACE_LINK_LIBRARIES ${OPENSSL_LIBSSL_DEPENDENCIES})

  # Directories and names compatible with CMake's FindOpenSSL.cmake
  set(OPENSSL_CRYPTO_LIBRARY ${OPENSSL_LIBCRYPTO_STATIC})
  set(OPENSSL_CRYPTO_LIBRARIES ${OPENSSL_CRYPTO_LIBRARY} ${OPENSSL_LIBCRYPTO_DEPENDENCIES})
  set(OPENSSL_SSL_LIBRARY ${OPENSSL_LIBSSL_STATIC})
  set(OPENSSL_SSL_LIBRARIES ${OPENSSL_SSL_LIBRARY} ${OPENSSL_LIBSSL_DEPENDENCIES})
  set(OPENSSL_LIBRARIES ${OPENSSL_SSL_LIBRARY} ${OPENSSL_LIBSSL_DEPENDENCIES} ${OPENSSL_LIBCRYPTO_DEPENDENCIES})

else()

  add_library(OpenSSL::Crypto SHARED IMPORTED)
  add_library(OpenSSL::SSL SHARED IMPORTED)

  set(OPENSSL_LIBCRYPTO_SHARED "${OPENSSL_RUNTIME_DIR}/libcrypto-3-x64.dll")
  set(OPENSSL_LIBCRYPTO_IMPORT "${OPENSSL_LIBRARY_DIR}/libcrypto.lib")
  set(OPENSSL_LIBCRYPTO_DEPENDENCIES )
  set_target_properties(OpenSSL::Crypto PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    IMPORTED_IMPLIB ${OPENSSL_LIBCRYPTO_IMPORT}
    IMPORTED_LOCATION ${OPENSSL_LIBCRYPTO_SHARED})
  set_property(TARGET OpenSSL::Crypto
    PROPERTY INTERFACE_LINK_LIBRARIES ${OPENSSL_LIBCRYPTO_DEPENDENCIES})

  set(OPENSSL_LIBSSL_SHARED "${OPENSSL_RUNTIME_DIR}/libssl-3-x64.dll")
  set(OPENSSL_LIBSSL_IMPORT "${OPENSSL_LIBRARY_DIR}/libssl.lib")
  set(OPENSSL_LIBSSL_DEPENDENCIES OpenSSL::Crypto )
  set_target_properties(OpenSSL::SSL PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    IMPORTED_IMPLIB ${OPENSSL_LIBSSL_IMPORT}
    IMPORTED_LOCATION ${OPENSSL_LIBSSL_SHARED})
  set_property(TARGET OpenSSL::SSL
    PROPERTY INTERFACE_LINK_LIBRARIES ${OPENSSL_LIBSSL_DEPENDENCIES})

  # Directories and names compatible with CMake's FindOpenSSL.cmake
  set(OPENSSL_CRYPTO_LIBRARY ${OPENSSL_LIBCRYPTO_IMPORT})
  set(OPENSSL_CRYPTO_LIBRARIES ${OPENSSL_CRYPTO_LIBRARY} ${OPENSSL_LIBCRYPTO_DEPENDENCIES})
  set(OPENSSL_SSL_LIBRARY ${OPENSSL_LIBSSL_IMPORT})
  set(OPENSSL_SSL_LIBRARIES ${OPENSSL_SSL_LIBRARY} ${OPENSSL_LIBSSL_DEPENDENCIES})
  set(OPENSSL_LIBRARIES ${OPENSSL_SSL_LIBRARY} ${OPENSSL_LIBSSL_DEPENDENCIES} ${OPENSSL_LIBCRYPTO_DEPENDENCIES})


endif()

set_target_properties(OpenSSL::Crypto PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}")
set_target_properties(OpenSSL::SSL PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}")


add_library(OpenSSL::applink INTERFACE IMPORTED)
set_property(TARGET OpenSSL::applink PROPERTY
  INTERFACE_SOURCES "${OPENSSL_APPLINK_SOURCE}")


unset(_ossl_prefix)
unset(_ossl_use_static_libs)
