#!/bin/bash

read -p "Введите адрес для пинга:" address

counter_failures=0

while true

do

ping_time=$(ping -c 1 $address 2>/dev/null | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')

if [[ -n "$ping_time" ]]

then

if (( $(echo "$ping_time <100" | bc -l) ))

then

echo "Время пинга: $ping_time мс"

counter_failures=0

else

echo "Время пинга превышает 100мс: $ping_time mc"
fi

else 

echo "Не удалось выполнить пинг $address."
((counter_failures+++))


if (( $counter_failures >= 3 ))

then

echo "Не удалось выполнить пинг в течении 3 последовательных попыток"
exit 1

fi
fi

sleep 1
done
