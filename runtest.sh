#/bin/sh

VIMRC_FILE="vest/.vimrc"
DRIVER_FILE="vest/_runner"
RESULT_FILE="vest/test_result.log"

if [ ! -d "./neobundle.vim" ]; then
  echo "`date "+[%Y-%m-%dT%H:%M:%S]"` Installing neobundle"
  git clone https://github.com/Shougo/neobundle.vim
fi

if [ -f "${RESULT_FILE}" ]; then
  rm ${RESULT_FILE}
fi

echo "`date "+[%Y-%m-%dT%H:%M:%S]"` Run vesting."
vim -u ${VIMRC_FILE} -s ${DRIVER_FILE}
echo "`date "+[%Y-%m-%dT%H:%M:%S]"` Done."
echo "`date "+[%Y-%m-%dT%H:%M:%S]"` Result: (${RESULT_FILE})"
cat ${RESULT_FILE}

grep -E "\[Fail\]" ${RESULT_FILE} > /dev/null

if [ $? -eq 0 ]; then
  echo "`date "+[%Y-%m-%dT%H:%M:%S]"` Test was failed."
  exit 1
else
  echo "`date "+[%Y-%m-%dT%H:%M:%S]"` Test was succeed."
  exit 0
fi

