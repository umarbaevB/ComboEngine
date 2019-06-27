# Sets the following variables

# GLM_INCLUDE_DIRS - include directories for GLM
# GLM_FOUND - true if GLM has been found and can be used

SET(GLM_FOUND "NO")

# default search dirs
SET(_glm_SEARCH_DIRS
	"./libs/glm"
    "${CMAKE_CURRENT_SOURCE_DIR}/libs/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/libs/glm"
    "/usr/include"
    "/usr"
    "/usr/local"
	"/usr/local/include"
	"/opt"
	"/Library/Frameworks"
	"~/Library/Frameworks"
    )

# check environment variable
SET(_glm_ENV_ROOT_DIR "$ENV{GLM_ROOT_DIR}")

# set GLM ROOT if needed
IF(NOT GLM_ROOT_DIR AND _glm_ENV_ROOT_DIR)
    SET(GLM_ROOT_DIR "${_glm_ENV_ROOT_DIR}")
ENDIF(NOT GLM_ROOT_DIR AND _glm_ENV_ROOT_DIR)

IF(GLM_ROOT_DIR)
    SET(_glm_SEARCH_DIRS "${GLM_ROOT_DIR}"
                                "${GLM_ROOT_DIR}"
                                 ${_glm_SEARCH_DIRS})
ENDIF(GLM_ROOT_DIR)

FIND_PATH(GLM_INCLUDE_DIRS
		glm.hpp glm/glm.hpp
		${_glm_SEARCH_DIRS}/include 
		DOC "GLM include directory"
)

IF (GLM_INCLUDE_DIRS )
	SET(GLM_FOUND TRUE)
	MESSAGE(STATUS "GLM_INCLUDE_DIRS = ${GLM_INCLUDE_DIRS}")
ELSE ( GLM_INCLUDE_DIRS )
	SET( GLM_FOUND FALSE)
	MESSAGE(STATUS "GLM not found")
ENDIF ( GLM_INCLUDE_DIRS )