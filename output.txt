def main():
    names = []
    ages = []
    gpas = []
    names.append("Иван")
    ages.append(20)
    gpas.append(4.5)
    names.append("Мария")
    ages.append(19)
    gpas.append(4.8)
    names.append("Петр")
    ages.append(21)
    gpas.append(4.2)
    names.append("Анна")
    ages.append(18)
    gpas.append(4.9)
    names.append("Олег")
    ages.append(22)
    gpas.append(3.8)
    print("Список студентов:")
    for i in range(0, len(names)):
        print(names[i], end='')
        print(" (Возраст ", end='')
        print(ages[i], end='')
        print(") - средний балл: ", end='')
        print(gpas[i])
    totalGPA = 0.0
    for i in range(0, len(gpas)):
        totalGPA = totalGPA + gpas[i]
    averageGPA = totalGPA / len(gpas)
    print("Средний балл по группе: ", end='')
    print(averageGPA)
    print()
    maxGPA = gpas[0]
    minGPA = gpas[0]
    bestIndex = 0
    worstIndex = 0
    for i in range(1, len(gpas)):
        if gpas[i] > maxGPA:
            maxGPA = gpas[i]
            bestIndex = i
        else:
            if gpas[i] < minGPA:
                minGPA = gpas[i]
                worstIndex = i
    print("Результаты анализа:")
    print("Лучший студент: ", end='')
    print(names[bestIndex], end='')
    print(" - ", end='')
    print(maxGPA)
    print("Худший студент: ", end='')
    print(names[worstIndex], end='')
    print(" - ", end='')
    print(minGPA)
    if averageGPA >= 4.5:
        print("Отличная группа!")
    else:
        if averageGPA >= 4.0:
            print("Хорошая группа.")
        else:
            print("Нужно подтянуть оценки.")
    print()
    bonusPoints = 0
    for i in range(0, len(gpas)):
        if gpas[i] >= 4.5 and ages[i] < 21:
            print("Молодой отличник найден: ", end='')
            print(names[i], end='')
            print()
            bonusPoints = bonusPoints + 1
    print("Количество студентов с успеваемостью >=4.5: ", end='')
    print(bonusPoints, end='')
    print()
    testA = 10
    testB = 3
    print("Арифметические операции 10 и 3:")
    print(testA + testB)
    print(testA - testB)
    print(testA * testB)
    print(testA / testB)
    print(testA % testB)
    print()
    print("Обратный отсчет:")
    countdown = 3
    while countdown >= 0:
        print(countdown)
        countdown = countdown - 1
    print("Завершение работы программы")


if __name__ == "__main__":
    main()
