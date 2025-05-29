#!/bin/sh
##############################################################################

ROOT_DIR=$( dirname "$( readlink -f "${0}" )" )
DOTFILES_DIR="${ROOT_DIR}/dotfiles"
SCRIPTS_DIR="${ROOT_DIR}/scripts"
ORIG_DIR="${HOME}/.orig"

##############################################################################

mkdir -p "${ORIG_DIR}" || exit "${?}"

##############################################################################

cd "${DOTFILES_DIR}" || exit "${?}"
for FILE in * .*
do
    [ '' = "${FILE}" ] && continue
    [ '.' = "${FILE}" ] && continue
    [ '..' = "${FILE}" ] && continue
    [ '*' = "${FILE}" ] && continue
    [ '.*' = "${FILE}" ] && continue
    [ -e "${HOME}/${FILE}" ] && {
    	if [ -e "${ORIG_DIR}/${FILE}" ]
	    then
	        echo "INFO: removing dotfile '${FILE}' as it exists in '${ORIG_DIR}'" >&2
	        rm -rf "${HOME}/${FILE}"
	    else
	        echo "INFO: moving dotfile '${FILE}' to '${ORIG_DIR}'" >&2
	        mv "${HOME}/${FILE}" "${ORIG_DIR}/${FILE}"
	    fi
    }
    echo "INFO: linking dotfile '${FILE}' to '${HOME}'" >&2
    ln -s "${DOTFILES_DIR}/${FILE}" "${HOME}/${FILE}"
done

##############################################################################

cd "${SCRIPTS_DIR}" || exit "${?}"
for FILE in *
do
    [ '' = "${FILE}" ] && continue
    [ '*' = "${FILE}" ] && continue
    echo "INFO: running script '${FILE}'" >&2
    "./${FILE}"
done
