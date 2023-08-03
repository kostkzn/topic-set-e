#!/bin/bash

function Error_handler() {
    set -e 
    echo "Error occur at line $1"
}
trap 'Error_handler $LINENO' ERR

# Приклад виклику помилки, опис якої може не вивестись у термінал
false

# Цей рядок ніколи не буде виконаний
echo "$(basename ./example2.sh) is executed"


# Якщо прибрати лінію set -e, то скрипт виконається до кінця
# Output:
# Error occur at line 10
# example2.sh is executed


