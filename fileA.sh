#!/bin/bash

# У цьому прикладі розглядається використання двох файлів bash: fileA.sh, fileB.sh. 
# У файлі fileA.sh ми використали "set -e", а у fileB.sh не використовується. 
# У файлі fileA.sh ми використали тільки виклик функції, 
# тоді як у fileB.sh оголошено все тіло функції. 
# Ми зв'язали обидва файли за допомогою ключового команди "source", 
# щоб виклик функції у fileA.sh міг виконати функцію з файлу fileB.sh.

set -e
# shellcheck source=/dev/null
source "fileB.sh"
echo "Notification: $(helo)"
echo "OK"

# Output
# $ ./fileA.sh
# Notification: Wait: there exists an error
# OK

# "exit 1" завершує виконання субпроцесу $(helo), який не впливає на 
# управління "set -e" файлу fileA.sh
