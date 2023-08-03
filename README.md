# Bash `set -e` usage

Вбудована функція `set -e` використовується для миттєвого виходу з виконання коду скрипта при помилках або при отриманні ненульового статусу.  

## Simple usage

Цей приклад демонструє розуміння `set -e`.

Оголошуємо чотири функції: `test1`, `test2`, `test3`, `test4`.
Ми мануально встановили статус "0" тільки для функції `test1`.
Усі інші функції повертають 1.  

За ідеєю код має завершиться після виконання функції test1. Однак цього не станеться.

~~~bash
#!/bin/bash

function test1() {
    echo "Test1: we have {set +e; return 0} so it continues"
    return 0
}

function test2() {
    echo "Test2: we have {set +e; return 1} but it continues"
    return 1
}

function test3() {
    echo "Test3: we have {set -e; return 1} and we stop the execution here"
    return 1
}

function test4() {
    echo "Test4: we have {set -e; return 1}"
    return 1
}

set +e
test1
test2
set -e
test3
test4
~~~

~~~shell
$ ./example.sh
Test1: we have {set +e; return 0} so it continues
Test2: we have {set +e; return 1} but it continues
Test3: we have {set -e; return 1} and we stop the execution here
~~~

Тут ми використали `set +e`, яка є протилежністю `set -e`.  

Якщо `set -e` змусить завершити виконання коду, то `set +e` протистоятиме виходу,
коли зустріне ненульове значення.
У прикладі `set +e` оголошується перед викликом `test1` та `test2`, а `set -e` перед `test3` та `test4`.

## Variations

Використовувати `set -e` можна всередині тіла функції.

~~~bash
#!/bin/bash

function hello() {
    set -e
    echo "Python is a good programming laguage"
}

hello
~~~

## Error handling function

Команду `trap` можна використати з обробником сигналів `ERR` для перехоплення помилок.

~~~bash
#!/bin/bash

function Error_handler() {
    set -e 
    echo "Error occur at line $1"
}
trap 'Error_handler $LINENO' ERR

# Приклад виклику помилки, явний опис якої може не вивестись у термінал
false

# Цей рядок ніколи не буде виконаний
echo "$(basename ./example2.sh) is executed"
~~~

~~~shell
$ ./example2.sh
Error occur at line 10
~~~
