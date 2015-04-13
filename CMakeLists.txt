############################################################################
# CMakeLists.txt
# Copyright (C) 2015  Belledonne Communications, Grenoble France
#
############################################################################
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
############################################################################

cmake_minimum_required(VERSION 3.0)
project(ILBCRFC3951 C)


find_program(AWK_PROGRAM awk)
if(NOT AWK_PROGRAM)
	message(FATAL_ERROR "You need the awk program to build libilbcrfc3951.")
endif()

set(EXTRACTED_SOURCES
	${CMAKE_CURRENT_BINARY_DIR}/FrameClassify.c
	${CMAKE_CURRENT_BINARY_DIR}/FrameClassify.h
	${CMAKE_CURRENT_BINARY_DIR}/LPCdecode.c
	${CMAKE_CURRENT_BINARY_DIR}/LPCdecode.h
	${CMAKE_CURRENT_BINARY_DIR}/LPCencode.c
	${CMAKE_CURRENT_BINARY_DIR}/LPCencode.h
	${CMAKE_CURRENT_BINARY_DIR}/StateConstructW.c
	${CMAKE_CURRENT_BINARY_DIR}/StateConstructW.h
	${CMAKE_CURRENT_BINARY_DIR}/StateSearchW.c
	${CMAKE_CURRENT_BINARY_DIR}/StateSearchW.h
	${CMAKE_CURRENT_BINARY_DIR}/anaFilter.c
	${CMAKE_CURRENT_BINARY_DIR}/anaFilter.h
	${CMAKE_CURRENT_BINARY_DIR}/constants.c
	${CMAKE_CURRENT_BINARY_DIR}/constants.h
	${CMAKE_CURRENT_BINARY_DIR}/createCB.c
	${CMAKE_CURRENT_BINARY_DIR}/createCB.h
	${CMAKE_CURRENT_BINARY_DIR}/doCPLC.c
	${CMAKE_CURRENT_BINARY_DIR}/doCPLC.h
	${CMAKE_CURRENT_BINARY_DIR}/enhancer.c
	${CMAKE_CURRENT_BINARY_DIR}/enhancer.h
	${CMAKE_CURRENT_BINARY_DIR}/filter.c
	${CMAKE_CURRENT_BINARY_DIR}/filter.h
	${CMAKE_CURRENT_BINARY_DIR}/gainquant.c
	${CMAKE_CURRENT_BINARY_DIR}/gainquant.h
	${CMAKE_CURRENT_BINARY_DIR}/getCBvec.c
	${CMAKE_CURRENT_BINARY_DIR}/getCBvec.h
	${CMAKE_CURRENT_BINARY_DIR}/helpfun.c
	${CMAKE_CURRENT_BINARY_DIR}/helpfun.h
	${CMAKE_CURRENT_BINARY_DIR}/hpInput.c
	${CMAKE_CURRENT_BINARY_DIR}/hpInput.h
	${CMAKE_CURRENT_BINARY_DIR}/hpOutput.c
	${CMAKE_CURRENT_BINARY_DIR}/hpOutput.h
	${CMAKE_CURRENT_BINARY_DIR}/iCBConstruct.c
	${CMAKE_CURRENT_BINARY_DIR}/iCBConstruct.h
	${CMAKE_CURRENT_BINARY_DIR}/iCBSearch.c
	${CMAKE_CURRENT_BINARY_DIR}/iCBSearch.h
	${CMAKE_CURRENT_BINARY_DIR}/iLBC_decode.c
	${CMAKE_CURRENT_BINARY_DIR}/iLBC_decode.h
	${CMAKE_CURRENT_BINARY_DIR}/iLBC_define.h
	${CMAKE_CURRENT_BINARY_DIR}/iLBC_encode.c
	${CMAKE_CURRENT_BINARY_DIR}/iLBC_encode.h
	${CMAKE_CURRENT_BINARY_DIR}/iLBC_test.c
	${CMAKE_CURRENT_BINARY_DIR}/lsf.c
	${CMAKE_CURRENT_BINARY_DIR}/lsf.h
	${CMAKE_CURRENT_BINARY_DIR}/packing.c
	${CMAKE_CURRENT_BINARY_DIR}/packing.h
	${CMAKE_CURRENT_BINARY_DIR}/syntFilter.c
	${CMAKE_CURRENT_BINARY_DIR}/syntFilter.h
)
set_source_files_properties(${EXTRACTED_SOURCES} PROPERTIES GENERATED TRUE)

add_custom_command(OUTPUT ${EXTRACTED_SOURCES}
	COMMAND ${AWK_PROGRAM} -f ${CMAKE_CURRENT_SOURCE_DIR}/downloads/extract-cfile.awk ${CMAKE_CURRENT_SOURCE_DIR}/downloads/rfc3951.txt
	WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)


include_directories(
	${CMAKE_CURRENT_BINARY_DIR}
)


add_library(ilbcrfc3951 STATIC ${EXTRACTED_SOURCES})
target_link_libraries(ilbcrfc3951)

install(TARGETS ilbcrfc3951 EXPORT IlbcRfc3951Targets
	RUNTIME DESTINATION bin
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib
	PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
)

set(HEADER_FILES
	${CMAKE_CURRENT_BINARY_DIR}/iLBC_decode.h
	${CMAKE_CURRENT_BINARY_DIR}/iLBC_define.h
	${CMAKE_CURRENT_BINARY_DIR}/iLBC_encode.h
)

install(FILES ${HEADER_FILES}
	DESTINATION include/ilbc
	PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
)


include(CMakePackageConfigHelpers)
write_basic_package_version_file(
	"${CMAKE_CURRENT_BINARY_DIR}/IlbcRfc3951ConfigVersion.cmake"
	VERSION 0.7
	COMPATIBILITY AnyNewerVersion
)
export(EXPORT IlbcRfc3951Targets
	FILE "${CMAKE_CURRENT_BINARY_DIR}/IlbcRfc3951Targets.cmake"
	NAMESPACE BelledonneCommunications::
)
configure_file(IlbcRfc3951Config.cmake
	"${CMAKE_CURRENT_BINARY_DIR}/IlbcRfc3951Config.cmake"
	COPYONLY
)

set(ConfigPackageLocation lib/cmake/IlbcRfc3951)
install(EXPORT IlbcRfc3951Targets
	FILE IlbcRfc3951Targets.cmake
	NAMESPACE BelledonneCommunications::
	DESTINATION ${ConfigPackageLocation}
)
install(FILES
	"${CMAKE_CURRENT_BINARY_DIR}/IlbcRfc3951Config.cmake"
	"${CMAKE_CURRENT_BINARY_DIR}/IlbcRfc3951ConfigVersion.cmake"
	DESTINATION ${ConfigPackageLocation}
)
