def main():
    numbers = []
    numbers.append(1)
    numbers.append(2)
    numbers.append(3)
    numbers.append(4)
    numbers.append(5)
    print("Список элементов: ", end='')
    for i in range(0, len(numbers)):
        print(numbers[i], end='')
        print(" ", end='')
    print("")
    n = 5
    result = 1
    temp = n
    while temp > 1:
        result = result * temp
        temp = temp - 1
    print("Факториал ", end='')
    print(n, end='')
    print(" - это ", end='')
    print(result)
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
    print("Список студентов")
    for i in range(0, len(names)):
        print(names[i], end='')
        print(" (Возраст ", end='')
        print(ages[i], end='')
        print(") - средний балл: ", end='')
        print(gpas[i])
    totalGPA = 0.0
    for i in range(0, len(gpas)):
        totalGPA = totalGPA + gpas[i]
    if len(gpas) > 0:
        print("Средний балл: ", end='')
        print(totalGPA / len(gpas))
    else:
        print("Не введены студенты")
    print("Программа успешно выполнена!")


if __name__ == "__main__":
    main()
