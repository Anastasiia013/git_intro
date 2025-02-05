#!/bin/bash

# Запрашиваем или получаем адрес
TARGET=${1:-$(read -p "Введите адрес: " ADDR && echo "$ADDR")}

FAILED_COUNT=0

while true; do
    # Запускаем пинг и извлекаем время
    TIME=$(ping -c 1 -W 1 "$TARGET" | awk -F'time=' '/time=/ {print $2+0}')

    if [[ -z "$TIME" ]]; then
        ((FAILED_COUNT++))
        echo "Ошибка пинга ($FAILED_COUNT/3)"
        ((FAILED_COUNT == 3)) && echo "Соединение потеряно" && FAILED_COUNT=0
    else
	    FAILED_COUNT=0
        ((TIME > 100)) && echo "Высокий пинг: ${TIME} мс" || echo "Пинг: ${TIME} мс"
    fi

    sleep 1
done

