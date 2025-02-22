#!/bin/bash

# TÍTULO DEL DOCUMENTO: Farmear FEH (FEH Farming).
# NOMBRE DEL ARCHIVO: feh-farming.sh
# AUTOR: Umbral1013.
# PROPÓSITO: Dependiendo del día, ejecuta la secuencia de pasos necesarios
#   para farmear plumas de héroe en Fire Emblem: Heroes. Para más
#   información, consulte https://youtube.com/watch?v=onaG5uom_xA
# FECHA: mar 22 ago 2023 19:03:32

# El signo de = tiene que estar pegado XD.
APP_NAME="FEH Farming"
COUNTER=0

function sunday {
    adb shell input tap 230 690     # Touch the difficulty selection
    adb shell input tap 240 520     # Touch on go
    sleep 3                         # Wait one second
    adb shell input tap 20 20       # Stop the animation
    sleep 3
    adb shell input tap 400 30      # Omit the dialogue
    sleep 2
    adb shell input tap 372 813     # Choose auto combat
    adb shell input tap 240 415     # Accept
    sleep 20                        # Wait until the combat finishes
    adb shell input tap 20 20       # Tap on stage clear
    sleep 8
}

function monday {
    adb shell input tap 240 430     # Touch the difficulty selection
    adb shell input tap 240 520     # Touch on go
    sleep 3                         # Wait one second
    adb shell input tap 20 20       # Stop the animation
    sleep 3
    adb shell input tap 400 30      # Omit the dialogue
    sleep 2
    adb shell input tap 372 813     # Choose auto combat
    adb shell input tap 240 415     # Accept
    sleep 15                        # Wait until the combat finishes
    adb shell input tap 20 20       # Tap on stage clear
    sleep 12
}

function tuesday {
    adb shell input tap 240 580     # Touch the difficulty selection
    adb shell input tap 240 520     # Touch on go
    sleep 3                         # Wait one second
    adb shell input tap 20 20       # Stop the animation
    sleep 3
    adb shell input tap 400 30      # Omit the dialogue
    sleep 2
    adb shell input tap 372 813     # Choose auto combat
    adb shell input tap 240 415     # Accept
    sleep 12                        # Wait until the combat finishes
    adb shell input tap 20 20       # Tap on stage clear
    sleep 10
}

function wednesday {
    adb shell input tap 240 430     # Touch the difficulty selection
    adb shell input tap 240 520     # Touch on go
    sleep 3                         # Wait one second
    adb shell input tap 20 20       # Stop the animation
    sleep 3
    adb shell input tap 400 30      # Omit the dialogue
    sleep 2
    adb shell input tap 372 813     # Choose auto combat
    adb shell input tap 240 415     # Accept
    sleep 12                        # Wait until the combat finishes
    adb shell input tap 20 20       # Tap on stage clear
    sleep 8
}

function thursday {
    adb shell input tap 230 440     # Touch the difficulty selection
    adb shell input tap 240 520     # Touch on go
    sleep 3                         # Wait one second
    adb shell input tap 20 20       # Stop the animation
    sleep 3
    adb shell input tap 400 30      # Omit the dialogue
    sleep 2
    adb shell input tap 372 813     # Choose auto combat
    adb shell input tap 240 415     # Accept
    sleep 12                        # Wait until the combat finishes
    adb shell input tap 20 20       # Tap on stage clear
    sleep 8
    adb shell input tap 240 680     # Accept rewards
    adb shell input tap 240 678     # Accept rewards
}

function friday {
    adb shell input tap 240 580     # Touch the difficulty selection
    adb shell input tap 240 520     # Touch on go
    sleep 3                         # Wait one second
    adb shell input tap 20 20       # Stop the animation
    sleep 3
    adb shell input tap 400 30      # Omit the dialogue
    sleep 2
    adb shell input tap 372 813     # Choose auto combat
    adb shell input tap 240 415     # Accept
    sleep 15                        # Wait until the combat finishes
    adb shell input tap 20 20       # Tap on stage clear
    sleep 8
}

#
# /// PRINCIPAL ///
#

# No entiendo ni la mitad de lo que dice este comando.
# De todos modos, comprueba si adb está instalado o no.
command -v adb >/dev/null 2>&1 || \
    { echo >&2 "Requiero de adb, pero no está instalado. Abortando..."; \
        exit 1; \
    }

notify-send --app-name=$APP_NAME "Farmeando ahora..."

while [ $COUNTER -lt 100 ]; do
    # Obtiene el número del día actual. 1 es lunes, 2 es martes...
    DAY=$(date +"%u")

    if [ $DAY = 1 ]; then
        monday
    elif [ $DAY = 2 ]; then
        tuesday
    elif [ $DAY = 3 ]; then
        wednesday
    elif [ $DAY = 4 ]; then
        thursday
    elif [ $DAY = 5 ]; then
        friday
    elif [ $DAY = 6 ]; then
        echo "Ups, de momento no hay ninguna rutina para el sábado."
        exit 1;
    elif [ $DAY = 7 ]; then
        sunday
    else
        echo "ERROR: Opción inesperada."
        exit 1;
    fi

    # Es lo mismo que 'COUNTER = $COUNTER + 1'
    let COUNTER+=1

done

notify-send --app-name=$APP_NAME "¡Listo! (He terminado)."
