#!/bin/bash

# Цей приклад демонструє розуміння "set -e". 
# Оголошуємо чотири функції: test1, test2, test3, test4. 
# Вбудована функція "set -e" використовується для виходу з коду при отриманні 
# ненульового статусу. 
# У нашому прикладі ми встановили статус "0" тільки для функції test1. 
# Усі інші повертають 1.
# За ідеєю код має завершиться після виконання функції test1. Однак цього не станеться.

# Тут ми використали "set +e", яка є протилежністю "set -e". 
# Якщо "set -e" змусить завершити виконання коду, то "set +e" протистоятиме виходу,
# коли зустріне ненульове значення.
# У прикладі "set +e" оголошується перед викликом test1 та test2, а "set -e" перед test3 і test4.

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

# Будуть виконані перші дві функції. 
# Оскільки test2 повертає ненульове значення, "set +e" нейтралізує виклик помилки. 
# Коли настане час test3, після виконання echo управління перейде до 
# значення "return 1" і код зупиниться. 
# Тому test4 виконується, бо ми не використали "set +e" перед нею. 
